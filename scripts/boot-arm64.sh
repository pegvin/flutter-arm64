#!/bin/sh

set -eu

codename="bookworm"
version="12"
img_url="https://cdimage.debian.org/images/cloud/$codename/latest/debian-$version-nocloud-arm64.qcow2"
img_file="./$(basename "$img_url")"

if [ ! -f "$img_file" ]; then
	echo "# Downloading $img_file"
	wget -4 -nv --show-progress -O "$img_file" "$img_url"
	qemu-img resize "$img_file" +17G
fi

echo "# Booting $img_file"
qemu-system-aarch64 -m 6G -M virt -smp $(nproc) -cpu max \
  -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd \
  -drive if=none,file="$img_file",id=hd0 -device virtio-blk-device,drive=hd0 \
  -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp:127.0.0.1:5555-:22 \
  -device virtio-gpu-pci \
  -virtfs local,path=./,mount_tag=host0,security_model=mapped,id=host0 \
  -nographic
