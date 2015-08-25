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
