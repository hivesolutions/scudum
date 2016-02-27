# Kernel

## Building

Building a kernel version and deploying it to the proper directories so that it can be used
by the proper boot loader can be achieved using the following command:

    MINOR=4.4.3 VARIANT=basic DEPLOY=1 kernel.build

To install a previously build kernel image (and modules) avoiding the rebuilding of the kernel
one should be connected with the target repository and the issue:

    VARIANT=large VERSION=current kernel.install

### Examples

To build a DVD ISO image of the latest Scudum system image, the basic kernel image and modules
and then deploy it to the repository one should issue.

    scu install scudum-tools cifs-utils
    scudum install && scudum mount
    KVARIANT=basic DEPLOY=1 scudum make.iso

To build a specialized version of Scudum (eg: docker) one should first clone the repository
and then start building the image under the proper context directory.

    git clone --depth 1 https://github.com/hivesolutions/scudum.git
    cd scudum/examples/docker
    scu install scudum-tools cifs-utils
    scudum install && scudum mount
    KVARIANT=basic DEPLOY=1 scudum make.iso
    cd ../../.. && rm -rf scudum

To build a Raspberry Pi 2 version of the armor example one should use:

    git clone --depth 1 https://github.com/hivesolutions/scudum.git
    cd scudum/examples/docker
    scu install scudum-tools cifs-utils
    ARCH=arm7 scudum install && scudum mount
    KVARIANT=rasp2 DEPLOY=1 scudum make.rasp
    cd ../../.. && rm -rf scudum

To safely build the latest kernel version and deploy it use:

    scu install scudum-system
    hash -r
    MINOR=4.4.3 VARIANT=basic DEPLOY=1 kernel.build

To build kernel for the Raspberry Pi, with the proper toolchain installed use, note that a
special variant exists for Raspberry Pi 2 kernel (`VARIANT=rasp2`):

    scu install scudum-system crosstool-rasp
    hash -r
    KARCH=arm KTARGET=/opt/arm-rasp-linux-gnueabi/bin/arm-rasp-linux-gnueabi DEPLOY=1 kernel.build

## Upgrading

The upgrading operation may be a complex one as it involves changing the configuration files 
