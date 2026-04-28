#!/bin/bash

VM_NAME="$1"
MAC_ADDRESS="$2"
HYPERVISOR="$3"
CPUNBR="$4"
RAMSIZE="$5"
DISKSIZE="$6"
ISOSRC="$7"

virsh --connect qemu+ssh://$HYPERVISOR/system undefine $VM_NAME --remove-all-storage
virsh --connect qemu+ssh://$HYPERVISOR/system vol-create-as --name $VM_NAME --pool vgnvme --capacity $DISKSIZE
#ssh $HYPERVISOR sudo dd if=/dev/zero of=/dev/vgnvme/$VM_NAME bs=1M count=8
ssh $HYPERVISOR sudo blkdiscard -f /dev/vgnvme/$VM_NAME

rsync -av --rsync-path='sudo rsync' $ISOSRC $HYPERVISOR:/var/lib/libvirt/images/$VM_NAME.iso

virt-install --connect qemu+ssh://$HYPERVISOR/system --name $VM_NAME \
        --boot=hd,cdrom \
        --cpu=host-passthrough \
        --ram=$RAMSIZE --vcpus=$CPUNBR \
        --disk=/var/lib/libvirt/images/$VM_NAME.iso,device=cdrom \
        --disk path=/dev/vgnvme/$VM_NAME,format=raw,cache=none \
        --network bridge=br0,model=virtio,mac=$MAC_ADDRESS \
        --graphics vnc --noautoconsole  \
        --osinfo="rhel9-unknown" --wait=-1 &

# --cpu=host-model
# --cpu=host-passthrough

# EOF
