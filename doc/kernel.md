# Kernel

## Building

Building a kernel version and deploying it to the proper directories so that it can be used
by the proper boot loader can be achieved using the following command:

    MINOR=4.11.9 VARIANT=basic DEPLOY=1 kernel.build

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

The upgrading operation may be a complex one as it involves changing the configuration files
