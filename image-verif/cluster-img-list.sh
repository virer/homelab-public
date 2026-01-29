#!/bin/bash

# Define registry and credentials
REGISTRY="default-route-openshift-image-registry.apps-crc.testing"

# 0. Cleanup
rm -f /tmp/image-inventory.lst /tmp/image-failed.lst

# 1. Collect unique images (excluding system namespaces)
echo "Collecting image list..."
oc get rs,sts,ds,deploy -A -o json | jq -r '.items[] | 
  select(.metadata.namespace | (startswith("openshift") or startswith("kube")) | not) | 
  .spec.template.spec | (.containers[]?.image, .initContainers[]?.image)' | sort -u > /tmp/image-inventory.lst

# 2. Login using skopeo 
echo " Authenticating with $REGISTRY..."
skopeo login -u "$(oc whoami)" -p "$(oc whoami -t)" --tls-verify=false "$REGISTRY" 
RET=$?
if [ "$RET" != "0" ]; then
 echo -e '\nError: Authentication failed !'
 exit 1
fi

# 3. Verify stored image layers
echo "Verifying stored image layers..."
IMGTMP_DIR=$(mktemp -d)

while read -r image; do
    # Skip empty lines if any
    [[ -z "$image" ]] && continue
	IMGTMP_DIR=$(mktemp -d)
    
    #echo -n "Checking: $image ... "
    
    # --src-tls-verify=false handles self-signed certs
    # --quiet hides the progress bars for a cleaner log
    skopeo copy --quiet --src-tls-verify=false --quiet "docker://$image" dir:$IMGTMP_DIR 2> /dev/null
	RET=$?

    if [ "$RET" == "0" ] ; then
        echo "OK" # $image"
    else
        echo "FAILED pulling $image" >&2
		echo $image >> /tmp/image-failed.lst
    fi

	# Cleanup to avoid disk full
    cd /tmp
	rm -rf "$IMGTMP_DIR"

done < /tmp/image-inventory.lst

# EOF
