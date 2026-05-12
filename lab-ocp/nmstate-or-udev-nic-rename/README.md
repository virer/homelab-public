# Persistent NIC naming on OpenShift nodes using udev or NMstate alias

**UDEV**:

- <https://docs.redhat.com/en/documentation/openshift_container_platform/4.20/html-single/hardware_accelerators/index#rdma-creating-persistent-naming-rules_rdma-remote-direct-memory-access>


**NMstate**:

- <https://docs.redhat.com/en/documentation/openshift_container_platform/4.18/html/kubernetes_nmstate/k8s-nmstate-updating-node-network-config#virt-creating-interface-on-nodes_k8s-nmstate-updating-node-network-config>
- <https://nmstate.io/examples.html>
- <https://nmstate.io/devel/api.html#interface-matching>


When choosing NNState NIC alias option, you can create an NNCP object like the following:

```yaml
---
apiVersion: nmstate.io/v1
kind: NodeNetworkConfigurationPolicy
metadata:
  name: rename-interface-vlan3-mac-000100050103
spec:
  nodeSelector:
    kubernetes.io/hostname: worker001.dmz.fqdn.example.com
  desiredState:
    interfaces:
      - name: myethvlan3
        alt-names:
        - name: myethvlan3
        type: ethernet
        state: up
        identifier: mac-address
        mac-address: '00:01:00:05:01:03'
        ipv4:
          enabled: true
          dhcp: true
          auto-gateway: false      # ← possible option to not accept default gateway from DHCP
          auto-routes: false       # ← possible option to not accept any routes from DHCP
          auto-dns: false          # ← possible option to not accept DNS from this interface
        ipv6:
          enabled: false
---
```

For udev rules (actually renaming NIC name using MAC):

```text
# NIC=enp*
SUBSYSTEM=="net" ACTION=="add", KERNEL=="enp*", ATTR{address}=="00:01:00:05:01:00", NAME="enp1s0"
SUBSYSTEM=="net" ACTION=="add", KERNEL=="enp*", ATTR{address}=="00:01:00:05:01:03", NAME="myethvlan2"
SUBSYSTEM=="net" ACTION=="add", KERNEL=="enp*", ATTR{address}=="00:01:00:05:01:04", NAME="myethvlan3"
SUBSYSTEM=="net" ACTION=="add", KERNEL=="enp*", ATTR{address}=="00:01:00:05:01:05", NAME="myethvlan4"
# NIC=eth*
SUBSYSTEM=="net" ACTION=="add", KERNEL=="eth*", ATTR{address}=="00:01:01:05:02:00", NAME="enp2s0"
SUBSYSTEM=="net" ACTION=="add", KERNEL=="eth*", ATTR{address}=="00:01:01:05:02:03", NAME="myethvlan2"
SUBSYSTEM=="net" ACTION=="add", KERNEL=="eth*", ATTR{address}=="00:01:01:05:02:04", NAME="myethvlan3"
SUBSYSTEM=="net" ACTION=="add", KERNEL=="eth*", ATTR{address}=="00:01:01:05:02:05", NAME="myethvlan4"
# NIC=ens*
SUBSYSTEM=="net" ACTION=="add", KERNEL=="ens*", ATTR{address}=="00:01:02:05:03:00", NAME="enp1s1"
SUBSYSTEM=="net" ACTION=="add", KERNEL=="ens*", ATTR{address}=="00:01:02:05:03:03", NAME="myethvlan2"
SUBSYSTEM=="net" ACTION=="add", KERNEL=="ens*", ATTR{address}=="00:01:02:05:03:04", NAME="myethvlan3"
SUBSYSTEM=="net" ACTION=="add", KERNEL=="ens*", ATTR{address}=="00:01:02:05:03:05", NAME="myethvlan4"
```

Then you can include it in a MachineConfig object like this:

```yaml
---
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata:
  labels:
    machineconfiguration.openshift.io/role: worker
  name: 95-worker-nic-renaming
spec:
  config:
    ignition:
      version: 3.5.0
    storage:
      files:
        - contents:
            compression: gzip
            source: data:;base64,H4sIAAAAAAAAA1NW8PN0tk3NK9DiCg51Co4MDnH1tbVVykstUVJwdA7x9PcD8hJTUpR0FLxdg/xcfYBckGog3zEkJKgaKFWUWlxcCxQ2MLAyMLQCkaYQBlCNn6OvK1iDYbGBEtVtMIbbkFuZWpJRlpOYZ0R9W0wwbTGmvi2mmLaYKHEpQ6KnJIOU6AGqxm2hIdhCI7ToMSIteoizgdLoIc4WSqOHOFvwRk9eMUm5pxiPhUZgC40xco8hSSmOKBsozj1E2UJx7iHKFuzRwwUAyt8ymd4EAAA=
          mode: 420
          overwrite: true
          path: /etc/udev/rules.d/10-network-persistent-custom-mac-address.rules
  kernelArguments:
    - loglevel=7
```
