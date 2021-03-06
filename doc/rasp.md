# Raspberry Pi Configuration

## Firmware

The (custom) Raspberry Pi firmware located at `/system/rasp` should be updated from time to time by using the [Raspberry Pi Firmware repository](https://github.com/raspberrypi/firmware/tree/master/boot) as the reference.

The update should be done taking into account that the Linux Kernel is going to be compiled and should not be part of the `/system/rasp` filesystem. Other files should also not be considered as part of the Scudum distribution.

A good explanation of the working in the boot loading process for each of these files can be found in [Embedded Linux - RPi Software](https://elinux.org/RPi_Software) page.

## Kernel configuration file

To be able to create a proper configuration file for the Raspberry Pi use the `bcmrpi_defconfig` for rasp1 and
`bcm2709_defconfig` for the rasp2 version of the machine.

These files may be found in the [Raspberry Pi Kernel repository](https://github.com/raspberrypi/linux/tree/rpi-4.19.y/arch/arm/configs).

Then add the following set of configuration lines so that proper EXT2 and EXT3 support is available.

```
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_DEFAULTS_TO_ORDERED=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
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

Set the proper build version to be used for `uname`.

```text
CONFIG_LOCALVERSION=".scudum.rasp.arm"
CONFIG_LOCALVERSION=".scudum.rasp2.arm"
```

Change the (default hostname) value of the machine to the Scudum value:

```text
CONFIG_DEFAULT_HOSTNAME="scudum"
```

Disable the LZ4 compression support, as it would require extra tools:

```text
# CONFIG_HAVE_KERNEL_LZ4 is not set
# CONFIG_KERNEL_LZ4 is not set
```

### Updating

The process of updating a rpy kernel configuration files should **always** start with the copy of the
corresponding base `*_defconfig` file from the [Raspberry Pi Kernel repository](https://github.com/raspberrypi/linux/tree/rpi-4.19.y/arch/arm/configs).

Try to avoid using the non master version of the kernel as most of the times they do not work under the
device itself as the branch only exists as a placeholder for future versions.

### Notes

By using the `make olddefconfig` all the remaining/new configuration lines not defined in the configuration
file are going to be populated with their respective default values according to the defined `ARCH`.
Check [this document](https://www.kernel.org/doc/makehelp.txt) for more information regarding kernel `make`
configuration options/parameters.
