# homelab

### TSR

OCP Cluster ID
```           
oc get clusterversion -o jsonpath='{.items[].spec.clusterID}{"\n"}'
```           


### Tricks

List OpenShift roles be ServiceAccount
```
oc get clusterrolebindings -o json | jq '.items[] | select(.subjects[].name | startswith("devspaces-operator"))'
oc get rolebindings -o json | jq '.items[] | select(.subjects[].name | startswith("devspaces-operator")) | .roleRef["name"]'
```


### Registry

OpenShift Registry ephemeral storage
```                                 
oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"storage":{"emptyDir":{}}}}'
```                                 

### ODF Support
 
Ceph status details:

Activate Ceph TOOL pod
https://access.redhat.com/articles/4628891

```                                 
oc -n openshift-storage get pod -l "app=rook-ceph-tools"
```                                 

if the tools' pods is running 

```                                 
oc -n openshift-storage rsh $(oc get pods -n openshift-storage -l app=rook-ceph-tools -o name)
```                                 

```                                 
$ bash
$ ceph -s
$ ceph osd df tree
$ ceph df
$ ceph osd perf
```                                 

Ceph verbose/debug 
https://access.redhat.com/articles/7004852


### OpenShift DNS toleration for taint storage 
```
oc patch dns.operator/default --type='json' -p='[{"op": "add", "path": "/spec/nodePlacement/tolerations", "value": [{"key": "node.ocs.openshift.io/storage", "operator": "Equal", "value": "true", "effect": "NoSchedule"}]}]'
```

### SSL/TLS

Show certicate chain
```                 
openssl s_client -connect example.com:443 -showcerts < /dev/null
```                 

### Bonding activate passive NIC

To use the passive network interface of the bonding : 

1. check the current active bonding interface status using 
   ```
   cat /proc/net/bonding/bond0
   ```

2. then active the passive network interface using
   ```
   echo secondary_nic > /sys/class/net/bond0/bonding/active_slave
   ```

