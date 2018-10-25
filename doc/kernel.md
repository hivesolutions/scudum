# Kernel

## Building

Building a kernel version and deploying it to the proper directories so that it can be used
by the proper boot loader can be achieved using the following command:

    MINOR=4.18.15 VARIANT=basic DEPLOY=1 kernel.build

To install a previously build kernel image (and modules) avoiding the rebuilding of the kernel
one should be connected with the target repository and the issue:

    VARIANT=large VERSION=latest kernel.install

Special versions of the kernel exist for the ARM process environment specially for usage under
the Raspberry Pi infra-structure for that the `crosstool` toolchain is required:

    scu install crosstool-rasp
    KARCH=arm \
    KTARGET=/opt/arm-rasp-linux-gnueabihf/bin/arm-rasp-linux-gnueabihf \
    VARIANT=rasp \
    DEPLOY=1 \
    kernel.build

To build the kernel optimized for Raspberry Pi 2 use `VARIANT=rasp2`.

## Upgrading

The upgrading operation may be a complex one as it involves changing the configuration files.

## (Proprietary) Firmware

In order to use some of the drivers custom and proprietary firmware may be required. The best way to
update these same package is to use the pre-compiled Ubuntu packages [here](https://packages.ubuntu.com/bionic/linux-firmware).

The newly created firmware package should be placed [here](https://github.com/hivesolutions/patches/tree/master/firmware). Whenever
a new package is created a merged with the previous one should be done.
