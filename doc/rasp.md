# Raspberry Pi Configuration

## Kernel configuration file

To be able to create a proper configuration file for the Raspberry Pi use the `bcmrpi_defconfig` for rasp1 and
`bcm2709_defconfig` for the rasp2 version of the machine.

These files may be found in the [Raspberry Pi Kernel repository](https://github.com/raspberrypi/linux/tree/rpi-4.1.y/arch/arm/configs).

Then add the following set of configuration lines so that proper ext2 and ext3 support is available.

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

Then add support for CRAMFS, SquashFS with the following configuration parameters.

```
CONFIG_CRAMFS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y´
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
```

Add the required support for OverlayFS for extra flexibility:

```
CONFIG_OVERLAY_FS=y
```
