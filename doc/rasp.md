# Raspberry Pi Configuration

## Firmware

The (custom) Raspberry Pi firmware located at `/system/rasp` should be updated from time to time by using the [Raspberry Pi Firmware repository](https://github.com/raspberrypi/firmware/tree/master/boot) as the reference.

The update should be done taking into account that the Linux Kernel is going to be compiled and should not be part of the `/system/rasp` filesystem. Other files should also not be considered as part of the Scudum distribution.

A good explanation of the working in the boot loading process for each of these files can be found in [Embedded Linux - RPi Software](https://elinux.org/RPi_Software) page.

## Kernel configuration file

To be able to create a proper configuration file for the Raspberry Pi use the `bcmrpi_defconfig` for rasp (Raspberry Pi 1 and Zero, `kernel.img`), the `bcm2709_defconfig` for rasp2 (Raspberry Pi 2, 3 and Zero 2 W, `kernel7.img`) and the arm64 `bcm2711_defconfig` for rasp8 (Raspberry Pi 4 and 5, `kernel8.img`, that also runs the 32 bit userland). There is no longer a 32 bit kernel for the Raspberry Pi 4.

These files may be found in the [Raspberry Pi Kernel repository](https://github.com/raspberrypi/linux/tree/rpi-6.18.y/arch/arm/configs) (and under `arch/arm64/configs` for rasp8).

Then add the following set of configuration lines so that proper EXT2 support is available (EXT3 is handled by the built-in EXT4 driver).

```
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
```

Then add support for CRAMFS and SquashFS with the following configuration parameters.

```text
CONFIG_CRAMFS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
```

Ensure that the Initrd support is available:

```text
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
```

Add the required support for OverlayFS for extra flexibility:

```text
CONFIG_OVERLAY_FS=y
```

Add the legacy (xtables) netfilter support, as Scudum's iptables is built without nftables, and the version 1 cgroup controllers used by the boot scripts (`CPUSETS_V1` requires SMP, so it does not apply to rasp):

```text
CONFIG_NETFILTER_XTABLES_LEGACY=y
CONFIG_IP_NF_IPTABLES_LEGACY=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP6_NF_IPTABLES_LEGACY=m
CONFIG_BRIDGE_NF_EBTABLES_LEGACY=m
CONFIG_MEMCG_V1=y
CONFIG_CPUSETS_V1=y
```

Keep the modules uncompressed, as Scudum installs and strips plain `.ko` files:

```text
# CONFIG_MODULE_COMPRESS is not set
```

Set the proper build version to be used for `uname`.

```text
CONFIG_LOCALVERSION=".scudum.rasp.arm"
CONFIG_LOCALVERSION=".scudum.rasp2.arm"
CONFIG_LOCALVERSION=".scudum.rasp8.aarch64"
```

Change the (default hostname) value of the machine to the Scudum value:

```text
CONFIG_DEFAULT_HOSTNAME="scudum"
```

Keep the gzip compression of the (32 bit) kernel image, as LZ4 would require extra tools:

```text
CONFIG_KERNEL_GZIP=y
```

### Updating

The process of updating a rpy kernel configuration files should **always** start with the copy of the
corresponding base `*_defconfig` file from the [Raspberry Pi Kernel repository](https://github.com/raspberrypi/linux/tree/rpi-6.18.y/arch/arm/configs).

Use the upstream default branch of the kernel, as the other branches are often placeholders for future versions that do not work under the device itself.

### Notes

By using the `make olddefconfig` all the remaining/new configuration lines not defined in the configuration
file are going to be populated with their respective default values according to the defined `ARCH`.
Check [this document](https://www.kernel.org/doc/makehelp.txt) for more information regarding kernel `make`
configuration options/parameters.
