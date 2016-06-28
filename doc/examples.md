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

#### Build the basic version of the 4.6.4 kernel and deploy

    MINOR=4.6.4 VARIANT=basic DEPLOY=1 kernel.build
