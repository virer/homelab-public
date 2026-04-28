# Enable nested virtualization in KVM
For those times when you need to run virtualization (e.g. vagrant with VirtualBox) _inside_ a KVM (libvirtd) guest.

The following taken from [Enabling nested virtualization in KVM](https://docs.fedoraproject.org/en-US/quick-docs/using-nested-virtualization-in-kvm/)
over on Fedora Docs.

1. Make sure that the Intel-VT-x/AMD-V extensions are enabled in the host machine's BIOS.
For Intel:

```
$ cat /proc/cpuinfo | grep vmx
```

For AMD:

```
$ cat /proc/cpuinfo | grep svm
```

2. Check to see if /etc/modprobe.d/kvm.conf exists and if it does not have the following line, add it
and reboot:

```
options kvm_amd nested=1
```

3. Go into the graphical virt-manager, open the subject guest's config, and click on "CPUs".

4. Check the box "Copy host CPU configuration" and Apply.

5. Restart the virtual machine, open a terminal in it and check for the extensions:

```
$ cat /proc/cpuinfo | grep vmx
```


## Validation
```
cat /sys/module/kvm_intel/parameters/nested
```

or

```
cat /sys/module/kvm_amd/parameters/nested
```


## Libvirt 
Change the following to the VM xml file:
<cpu mode='host-model' check='partial' />
to use the following:
<cpu mode='host-passthrough' check='none' />

Source:
https://gist.github.com/plembo/782e1511e463221b5772e85b6f2f72d4
https://www.howtogeek.com/devops/how-to-enable-nested-kvm-virtualization/
