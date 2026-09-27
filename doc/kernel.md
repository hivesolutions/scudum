# Kernel

## Dependencies

The latest versions of the kernel require `elfutils` to be able to compile.

```bash
scu install elfutils
```

## Building

Building a kernel version and deploying it to the proper directories so that it can be used
by the proper boot loader can be achieved using the following command:

```bash
MAJOR=7.x MINOR=7.2.7 VARIANT=basic DEPLOY=1 kernel.build
```

To install a previously build kernel image (and modules) avoiding the rebuilding of the kernel
one should be connected with the target repository and the issue:

```bash
VARIANT=large VERSION=latest kernel.install
```

Special versions of the kernel exist for the ARM process environment specially for usage under the Raspberry Pi infra-structure for that a cross compilation toolchain is required (eg: the Ubuntu one):

```bash
apt-get install gcc-arm-linux-gnueabihf
KARCH=arm \
KTARGET=arm-linux-gnueabihf \
VARIANT=rasp \
DEPLOY=1 \
kernel.build
```

To build the kernel for Raspberry Pi 2 and 3 use `VARIANT=rasp2`, and for Raspberry Pi 4 and 5 (64 bit) use `VARIANT=rasp8` with `KARCH=arm64` and `KTARGET=aarch64-linux-gnu` (from `gcc-aarch64-linux-gnu`).

## Upgrading

The upgrading operation may be a complex one as it involves changing the configuration files.

For some of the files (eg: `large` and `basic`) it might be interesting to use the Ubuntu config files stored in `/boot/config-xxx-generic` as a reference in the construction of them. For that install Ubuntu in a VM and then use **Ukuu** to upgrade the kernel to desired version.

An alternative way of building a base `.config` file from the Ubuntu distribution one is to download the `linux-modules-*.deb` file from the [https://kernel.ubuntu.com/~kernel-ppa/mainline/](https://kernel.ubuntu.com/~kernel-ppa/mainline/) repository and then extract the config file from it.

It may also be interesting to "port" the blacklisted modules from the Ubuntu distribution at `/etc/modprobe.d/blacklist-*.conf`.

For the Ubuntu configuration to work under Scudum environment these extra directives must be included:

```text
CONFIG_USB_STORAGE=y
```

Ensuring that proper CD-ROM and HD support is granted these lines should be added:

```text
CONFIG_ISO9660_FS=y
CONFIG_UDF_FS=y
CONFIG_SATA_AHCI=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_UTF8=y
```

Other than these the basic ones referred in the [Raspberry Pi Configuration](rasp.md#kernel-configuration-file) should also be included.

## (Proprietary) Firmware

In order to use some of the drivers custom and proprietary firmware may be required. The best way to
update these same package is to use the pre-compiled Ubuntu packages [here](https://packages.ubuntu.com/bionic/linux-firmware).

The newly created firmware package should be placed [here](https://github.com/hivesolutions/patches/tree/master/firmware). Whenever
a new package is created a merged with the previous one should be done.

The Raspberry Pi should have a special (smaller) firmware package retrieved from the Raspbian image file from the [download website](https://www.raspberrypi.org/downloads/raspbian/).
