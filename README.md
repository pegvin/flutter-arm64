# Flutter Linux ARM64
Flutter SDK For ARM64 Linux Host.

Building the Flutter SDK is pretty simple
(checkout [scripts/setup-flutter-sdk.sh](./scripts/setup-flutter-sdk.sh)),
but this repository exists to save up time
& computing resources by making a readily
downloadable SDK.

### Miscellaneous

You can also use [scripts/boot-arm64.sh](./scripts/boot-arm64.sh)
to boot a Debian 12 ARM64 VM using QEMU
(`sudo apt install qemu-utils qemu-efi-aarch64 qemu-system-arm`).

If this is your first time booting the VM,
You will need to do some setup, This can be
done by mounting the host passthrough filesystem
in the VM:

```
mkdir /mnt/tmp && mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt/tmp
```

And then running the `setup-guest.sh` script
located inside `/mnt/tmp/` (Should be inside
`/mnt/tmp/scripts/setup-guest.sh` but maybe
different depending on which directory you
booted the VM from). Then you can reboot the
system (`reboot now`) and login with username
`user` and password `123`.

### References
- <https://wiki.debian.org/Arm64Qemu>
- <https://superuser.com/questions/628169/how-to-share-a-directory-with-the-host-without-networking-in-qemu>
- <https://absprog.com/post/qemu-kvm-enlarge-disk>
- <https://www.reddit.com/r/FlutterDev/comments/1piz2g8/how_can_i_build_flutter_sdk_for_arm64_linux/>
  - <https://www.reddit.com/r/FlutterDev/comments/1piz2g8/comment/nt9ngiy/>
  - <https://www.reddit.com/r/FlutterDev/comments/1piz2g8/comment/nt9qibl/>
