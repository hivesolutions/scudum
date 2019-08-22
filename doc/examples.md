# Example scripts

## Building

### Basics

##### Mounting the repository share

    scudum mount

##### Building and deploying to repository

    DEPLOY=1 scudum make.usb

##### Using the basic kernel version

    KVARIANT=basic scudum make.usb

### Kernel

##### Build the basic version of the kernel and deploy

    VARIANT=basic DEPLOY=1 kernel.build

#### Build the basic version of the 5.2.9 kernel and deploy

    MINOR=5.2.9 VARIANT=basic DEPLOY=1 kernel.build
