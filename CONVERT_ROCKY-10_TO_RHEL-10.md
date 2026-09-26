# Convert Rocky Linux 10 to Red Hat Enterprise Linux 10 (RHEL 10)

This guide provides a lightweight, reliable procedure to convert a fresh Rocky Linux 10 bare-metal or virtual server into an official Red Hat Enterprise Linux 10 system using a downloaded RHEL 10 DVD ISO and a Red Hat Activation Key.

## Prerequisites

* A running **Rocky Linux 10** server with active internet connectivity.
* Root access to the server.
* An official **RHEL 10 DVD ISO** uploaded to the server (e.g., `/root/rhel-10-x86_64-dvd.iso`).
* An active **Red Hat Account** with an **Organization ID** and **Activation Key** configured in the Red Hat Customer Portal.

## Conversion procedure 

```bash     
export ISO_PATH="/root/rhel-10-x86_64-dvd.iso"
export ORG_ID="YOUR_ORG_ID"
export ACTIVATION_KEY="YOUR_ACTIVATION_KEY"
```    

# 1. Mount the downloaded RHEL 10 DVD ISO and copy key files

```bash     
mkdir -p /mnt/rhel-iso
mount -o loop "$ISO_PATH" /mnt/rhel-iso
cp /mnt/rhel-iso/RPM-GPG-KEY-redhat-release /tmp/
cp /mnt/rhel-iso/BaseOS/Packages/r/redhat-release-10*.rpm /tmp/
umount /mnt/rhel-iso
rmdir /mnt/rhel-iso
```   

# 2. Install subscription tools and import Red Hat GPG key

```bash     
dnf install -y subscription-manager
rpmkeys --import /tmp/RPM-GPG-KEY-redhat-release
```   

# 3. Swap Rocky Linux release branding for Red Hat Enterprise Linux

```bash  
rpm -ivh --replacepkgs --nodeps /tmp/redhat-release-10*.rpm
rpm -e --nodeps rocky-release rocky-repos rocky-gpg-keys 2>/dev/null || true
```

# 4. Register using Red Hat Org ID & Activation Key

```bash  
subscription-manager register --org "$ORG_ID" --activationkey "$ACTIVATION_KEY"
```

# 5. Sync packages over the network to official RHEL 10 CDN

```bash  
dnf clean all
dnf distro-sync -y --allowerasing
dnf reinstall -y kernel
```

# 6. Reboot into RHEL 10

```bash
reboot
```
