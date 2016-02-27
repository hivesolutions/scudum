# Kernel

## Building

Building a kernel version and deploying it to the proper directories so that it can be used
by the proper boot loader can be achieved using the following command:

    MINOR=4.4.3 VARIANT=basic DEPLOY=1 kernel.build

To install a previously build kernel image (and modules) avoiding the rebuilding of the kernel
one should be connected with the target repository and the issue:

    VARIANT=large VERSION=current kernel.install

## Upgrading

The upgrading operation may be a complex one as it involves changing the configuration files 
