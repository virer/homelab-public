#!/bin/bash
date

# Src: https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.16.35/openshift-install-linux-4.16.35.tar.gz
BIN=/usr/local/bin/openshift-install-linux-4.21.9
# BIN=/usr/local/bin/openshift-install-v4.21.0
# BIN=/usr/local/bin/openshift-install-v4.20.8
# BIN=/usr/local/bin/openshift-install-v4.19.16
# BIN=/usr/local/bin/openshift-install-v4.19.9
# BIN=/usr/local/bin/openshift-install-v4.19.6
# BIN=/usr/local/bin/openshift-install-v4.18.26
# BIN=/usr/local/bin/openshift-install-v4.18.22
# BIN=/usr/local/bin/openshift-install-v4.18.16
# BIN=/usr/local/bin/openshift-install-v4.18.5
# BIN=/usr/local/bin/openshift-install-v4.16.35
# BIN=/usr/local/bin/openshift-install-v4.16.18
# BIN=/usr/local/bin/openshift-install-v4.16.10
# BIN=/usr/local/bin/openshift-install-v4.14.48
# BIN=/usr/local/bin/openshift-install-v4.14.33

mkdir -p ~/opt
rm -rf ~/opt/agent
mv ~/.kube/config  ~/.kube/config.BAK

mkdir -m 700 ~/opt/agent
cp -v ocp-cfg/agent-config.yaml  ~/opt/agent/agent-config.yaml
# cp -v ocp-cfg/agent-config-dhcp.yaml  ~/opt/agent/agent-config.yaml
# cp -v examples/agent-config-ipv6.yaml  ~/opt/agent/agent-config.yaml

# cp -v ocp-cfg/4.14/install-config-agent-sdn.yaml ~/opt/agent/install-config.yaml
# cp -v ocp-cfg/4.14/install-config-agent-vCurrent.yaml ~/opt/agent/install-config.yaml
# cp -v ocp-cfg/4.16/install-vcurrent-config-agent.yaml ~/opt/agent/install-config.yaml
# cp -v ocp-cfg/4.16/install-noproxycache-agent.yaml ~/opt/agent/install-config.yaml
# cp -v ocp-cfg/4.18/install-config-agent.yaml ~/opt/agent/install-config.yaml
# cp -v ocp-cfg/4.18/install-config-agent-proxy-vCurrent.yaml ~/opt/agent/install-config.yaml
# cp -v ocp-cfg/4.18/install-config-agent-proxy-vCurrent-ipv6.yaml ~/opt/agent/install-config.yaml
# cp -v ocp-cfg/4.18/install-config-agent-vCurrent.yaml ~/opt/agent/install-config.yaml  # without registry proxy !
# cp -v ocp-cfg/4.18/install-config-agent-dual-stack.yaml ~/opt/agent/install-config.yaml
cp -v ocp-cfg/4.21/install-config-agent-proxy-vCurrent.yaml ~/opt/agent/install-config.yaml


cd ~/opt/agent

# XXX Kernel boot mode XXX
# $BIN agent create pxe-files

# $BIN create manifests --dir .
#sed -i 's/mastersSchedulable: .*$/mastersSchedulable: false/g' manifests/cluster-scheduler-02-config.yml
# $BIN create ignition-configs --dir .

# ISO MODE
# $BIN agent create image 
$BIN agent create image --log-level debug
ret=$?
if [ "$ret" != "0" ]; then
	echo "iso gen exit code $ret != 0"
	exit $ret
fi

cp -f ~/opt/agent/auth/kubeconfig ~/.kube/config

# XXX Kernel boot mode XXX
# cd boot-artifacts
# rsync -av agent.x86_64-initrd.img agent.x86_64.ipxe agent.x86_64-rootfs.img agent.x86_64-vmlinuz nanopi:/var/www/repo/ocp/agent/

# ***

CPUNBR="12" 
DISKSIZE="100G" 
# RAMSIZE="16384"
# RAMSIZE="20480"
# RAMSIZE="24000"
# RAMSIZE="34816"
RAMSIZE="48000"

/home/scaps/git/homelab/lab-ocp/orchestra/virt-cdrom-install.sh "etcd-1" "52:54:00:06:f9:7b" "virer@yolo"  $CPUNBR $RAMSIZE $DISKSIZE ~/opt/agent/agent.x86_64.iso

RAMSIZE="64000"
/home/scaps/git/homelab/lab-ocp/orchestra/virt-cdrom-install.sh "etcd-2" "52:54:00:06:f8:7c" "virer@rtx"   $CPUNBR $RAMSIZE $DISKSIZE ~/opt/agent/agent.x86_64.iso

CPUNBR="8"
RAMSIZE="48000"
/home/scaps/git/homelab/lab-ocp/orchestra/virt-cdrom-install.sh "etcd-3" "52:54:00:06:f7:7d" "virer@z240"  $CPUNBR $RAMSIZE $DISKSIZE ~/opt/agent/agent.x86_64.iso


date 

# EOF
