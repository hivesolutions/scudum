# Kernel

## Building

Building a kernel version and deploying it to the proper directories so that it can be used
by the proper boot loader can be achieved using the following command:

    MINOR=4.4.3 VARIANT=basic DEPLOY=1 kernel.build

To install a previously build kernel image (and modules) avoiding the rebuilding of the kernel
one should be connected with the target repository and the issue:

    VARIANT=large VERSION=current kernel.install

Special versions of the kernel exist for the ARM process environment specially for usage under
the Raspberry Pi infra-structure for that the `crosstool` toolchain is required:

    scu install crosstool-rasp
    KARCH=arm \
    KTARGET=/opt/arm-rasp-linux-gnueabi/bin/arm-rasp-linux-gnueabi \
    VARIANT=rasp1 \
    DEPLOY=1 \
    kernel.build

## Upgrading

The upgrading operation may be a complex one as it involves changing the configuration files 
