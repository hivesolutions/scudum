# Scudum

A simple Linux distribution for usage in colony, viriatum and tiberium distributed solutions.

Custom linux distribution that aims at providing an easy to use system for
[Viriatum](https://github.com/hivesolutions/viriatum) / [Automium](https://github.com/hivesolutions/automium) /
[Tiberium](https://github.com/hivesolutions/tiberium).

There are a series of [scripts](build/util) that aim at providing a simple to use toolchain for
scudum customization.

The distribution is meant to provide a simple raw system that should be configured from
configuration servers that are discoverable using auto-discover techniques (Zeroconf, etc).
Using scudum one could build an army of servers that are configurable from a single instance
so that replacing them is easy and cheap (without human intervention).

## Usage

### Examples

To enter into the current scudum development environment located under `/dev/sdb` use the following command:

    chroot.sh

To create an ISO image of the Scudum distribution running using the [ISOLINUX](http://www.syslinux.org) boot
loader use the following command taking note that the disk contents should be located at `/dev/sdb`:

    DEV_NAME=/dev/sdb make.iso.sh
    
Note that because the fstab file for the ISO version is different a rebuild operation should be performed
first to avoid problems, to do that use:

    DEV_NAME=/dev/sdb REBUILD=1 make.iso.sh
  
In order to create a Virtual Box compatible image (VDI) issue the command:

    DEV_NAME=/dev/sdb make.vdi.sh
    
To deploy a new version of the Scudum distrubtion to the repository use, note that the deployment
is going to use the `/mnt/builds/scudum` path by default but may be changed using the `TARGET` variable:

    VERSION=v1 deploy.sh

In order to work (change the scudum base system) you need to deploy the latest version into a local drive
(typically `/dev/sdb`) in order to do that use:

    DEV_NAME=/dev/sdb VERSION=latest install.dev.sh
    
Please be aware that `/dev/sdb` drive will be completely erased during this operation.

To create an `img` file of an hard drive and then install it on a device use (experimental):

    install.img.sh && sleep 10 && dd if=scudum.img of=/dev/sdb bs=1M

To restore the hard drive to the original (empty) state run the following command, note that this will
remove the scudum files from it.

    dd if=/dev/zero of=/dev/sdb bs=4096
    
As an alternative you may only remove the `MBR` from it as it's a faster operation.

    dd if=/dev/zero of=/dev/sdb bs=446 count=1

### Kernel building

Building a kernel version and deploying it to the proper directories so that it can be used
by the proper boot loader can be achieved using the following command:

    MINOR=3.12.6 kernel.build

## Armor

The armor client is the responsible for the installation of the various elements associated
with the instance that is booting.

The retrieval of the configuration should be done using a variaty of conditions that should
include MAC address, IP address and credentials. Such credentials should be stored in secondary
storage as part of the node configuration.

## Armord (daemon)

## Objectives

* Viriatum based web interface for configuration (scu installation and more)
* RAM only operative system (not required but objective)
* Easy auto configuration (Zeroconf and centralized server)
* Fast boot (< 10 sec)
* Low - Medium RAM usage (< 1 GB)

## Installation

Current version of scudum vary in deployment currently there are three different
options to choose from: DVD ISO, HD install and HD image.

### Links

Initramfs on LFS http://www.linuxfromscratch.org/blfs/view/svn/postlfs/initramfs.html

## TODO

* Light version of the kernel (less file systems)
* Support for [lxc](http://lxc.sourceforge.net/) Linux containers or for [Docker](http://docker.io)
* Optimization on RAM usage at boot post script on boot (http://www.stockwith.uklinux.net/hints/)
* Suport for PXE serving
* Support for scu files
* Removal of ssh files / key reconfiguration script
* Convert stuff into raspberry pi
  * [link 1](http://akanto.wordpress.com/2012/09/25/cross-compiling-kernel-for-raspberry-pi-on-fedora-17-part-1)
  * [link 2](http://wiki.gentoo.org/wiki/Raspberry_Pi)

## References

* http://coreos.com
* http://www.stockwith.uklinux.net/hints
