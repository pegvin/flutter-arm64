#!/bin/sh

set -eu

if [ ! -d "/mnt/host/" ]; then
	echo "# Adding host passthrough to /etc/fstab"
	mkdir -p /mnt/host/
	echo 'host0   /mnt/host/    9p      trans=virtio,version=9p2000.L   0 0' >> /etc/fstab
fi

echo "# Updating System"
sudo apt update -y
sudo apt upgrade -y

echo "# Installing Disk Resizing Utilities"
sudo apt install -y cloud-guest-utils fdisk

echo "# Resizing Disk"
root_mount=$(cat /proc/mounts | grep "/dev/vda[0-9] / " | cut -d ' ' -f1 | tr -d '\n')

if [ -z "$root_mount" ]; then
	echo "Error! Cannot determine root mount point!"
	exit 1
fi

growpart /dev/vda "$(echo "$root_mount" | sed 's/\/dev\/vda//')"
resize2fs "$root_mount"

echo "# Installing Required Packages"
sudo apt install -y git unzip clang cmake ninja-build pkg-config libgtk-3-dev libstdc++-12-dev mesa-utils

echo "# Creating New User"
useradd -m -p 123 -s /bin/bash -g users -G sudo user

echo "# Done"
