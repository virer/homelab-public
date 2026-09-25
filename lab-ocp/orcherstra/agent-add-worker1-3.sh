#!/bin/bash
set -v
oc extract -n openshift-machine-api secret/worker-user-data-managed --keys=userData --to=- > ~/opt/agent/worker.ign
# rsync -av ~/opt/agent/worker.ign pi@nanopi:/var/www/repo/ocp/ignition/worker.ign

cp -v ~/opt/agent/agent.x86_64.iso /tmp/worker.iso
/usr/local/bin/coreos-installer iso customize /tmp/worker.iso --dest-ignition ~/opt/agent/worker.ign --dest-device /dev/vda -f


DISKSIZE="100G"
RAMSIZE="16000"

/home/scaps/git/homelab/lab-ocp/orchestra/virt-cdrom-install.sh "worker-1" "52:54:00:06:d8:8c" "virer@yolo"  "8" $RAMSIZE $DISKSIZE /tmp/worker.iso

# /home/scaps/git/homelab/lab-ocp/orchestra/virt-cdrom-install.sh "worker-2" "52:54:00:06:d9:9d" "virer@rtx"   "8" $RAMSIZE $DISKSIZE /tmp/worker.iso
# /home/scaps/git/homelab/lab-ocp/orchestra/virt-cdrom-install.sh "worker-3" "52:54:00:06:e0:9e" "virer@z240"  "4" $RAMSIZE $DISKSIZE /tmp/worker.iso



# EOF
