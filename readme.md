# [![Scudum](res/logo.png)](http://scudum.hive.pt)

A simple Linux distribution for usage in colony, viriatum and tiberium distributed solutions.

Custom linux distribution that aims at providing an easy to use system for
[Viriatum](https://github.com/hivesolutions/viriatum) / [Automium](https://github.com/hivesolutions/automium) /
[Tiberium](https://github.com/hivesolutions/tiberium).

There are a series of [scripts](scripts/util) that aim at providing a simple to use toolchain for
scudum customization.

The distribution is meant to provide a simple raw system that should be configured from
configuration servers that are discoverable using auto-discover techniques (Zeroconf, etc).
Using scudum one could build an army of servers that are configurable from a single instance
so that replacing them is easy and cheap (without human intervention).

## Usage

### Environment

The currently recomended environments are Ubuntu 14.04+ or Scudum itself configured for building.

### Installation

In order to install the Scudum development tools, to be able to use the commands described in
the next section (examples) use:

    make install

### Reference

Building the Scudum root/base/development environment, a (very) long process of compilation of both the bootstrap
base tools and the base system infra-structure is required, to start the process use:

    scudum root

To start the Scudum build process building the latest version of GCC and setting the strict CFLAGS so that the
build is controlled and does not compile using any (unwanted) optimization and runnnig as a background task use:

    SET_CFLAGS=all GCC_FLAVOUR=latest scudum root < /dev/null &> /pst/scudum.log &

To be able to create a cross compilation based ARM build for the Raspberry Pi system you may change the way
the root environment is created with:

    SCUDUM_ARCH=arm6 SCUDUM_VENDOR=rasp SCUDUM_SYSTEM=linux-gnueabi \
    GCC_BUILD_ARCH=armv6zk GCC_BUILD_TUNE=arm1176jzf-s GCC_BUILD_FPU=vfp \
    GCC_BUILD_FLOAT=hard scudum root

It's possible to optimize the building process for the Raspberry Pi 2 for that the cpu specific configuration
must be changed, note that this is not backwards compatible:

    SCUDUM_ARCH=arm7 SCUDUM_VENDOR=rasp SCUDUM_SYSTEM=linux-gnueabi \
    GCC_BUILD_ARCH=armv7-a GCC_BUILD_TUNE=cortex-a7 GCC_BUILD_FPU=neon-vfpv4 \
    GCC_BUILD_FLOAT=hard scudum root

To be able to run only the system building (without repeating the cross toolchain and the base toochain process)
yo can use the following command:

    SCUDUM_ARCH=arm7 SCUDUM_VENDOR=rasp SCUDUM_SYSTEM=linux-gnueabi \
    GCC_BUILD_ARCH=armv7-a GCC_BUILD_TUNE=cortex-a7 GCC_BUILD_FPU=neon-vfpv4 \
    GCC_BUILD_FLOAT=hard BUILD_CLEAN=0 BUILD_ROOT=0 BUILD_CROSS=0 BUILD_TIMEOUT=1 scudum root

To deploy a new version of the Scudum ditribution to the repository a deploy operation must be performed,
note that the deployment is going to use the `/mnt/builds/scudum` path by default but may be changed
using the `TARGET` variable:

    scudum deploy

To install the latest available Scudum root/base/development environment a connection to the Internet must
exist and the following command should be executed:

    scudum install

To enter into the current Scudum development environment (root) deployed in the current machine use:

    scudum chroot

To create an ISO image of the Scudum distribution running using the [ISOLINUX](http://www.syslinux.org) boot
loader use the following command taking note that the disk contents should be located at `/scudum`:

    scudum make.iso

To crate a filesystem image able to be used inside a USB pend drive (configured with SYSLINUX) use the folowing
command:

    scudum make.usb

To be able to re-create a new Scudum deployment (into `/scudum`) and then build a new ISO from it (all of the operations)
use the following command (note that this operation may take some time):

    scudum all

In order to create a Virtual Box compatible image (VDI) issue the command:

    DEV_NAME=/dev/sdb make.vdi.sh

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

    MINOR=4.1.6 VARIANT=basic DEPLOY=1 kernel.build

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

To safely build the latest kernel version and deploy it use:

    scu install scudum-system
    hash -r
    MINOR=4.1.6 VARIANT=basic DEPLOY=1 kernel.build

To build kernel for the Raspberry Pi, with the proper toolchain installed use, note that a
special variant exists for Raspberry Pi 2 kernel (`VARIANT=rasp2`):

    scu install scudum-system crosstool-rasp
    hash -r
    KARCH=arm KTARGET=/opt/arm-rasp-linux-gnueabi/bin/arm-rasp-linux-gnueabi DEPLOY=1 kernel.build

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

### Usage

#### WPA (Wireless Networking)

As a quick start a simple one time configuration may be used with the following commands that
start the daemon for the wireless support and then run the DHCP client to obtain IP based information
that will be used to configure the interface.

    wpa_supplicant -B -i wlan0 -c <(wpa_passphrase YOUR_SSID YOUR_PASSPHRASE)
    dhclient wlan0

To be able to configure a wireless network interface using a more "persistent" approach one must
created/edit a configuration file for wireless interface under a location (eg: `/etc/wlan0.conf`):

    ctrl_interface=/run/wpa_supplicant
    update_config=1
    fast_reauth=1
    ap_scan=1
    network={
        ssid="YOUR_SSID"
        psk="YOUR_PASSPHRASE"
    }

Then to start the interface run the following commands to start wpa supplicant and then start the
dhclient to request DHCP based information.

    wpa_supplicant -B -i wlan0 -c /etc/wlan0.conf
    dhclient wlan0

### Links

Initramfs on LFS http://www.linuxfromscratch.org/blfs/view/svn/postlfs/initramfs.html

## TODO

* Light version of the kernel (less file systems)
* Optimization on RAM usage at boot post script on boot (http://www.stockwith.uklinux.net/hints/)
* Suport for PXE serving
* Support for scu files
* Convert stuff into raspberry pi
 * [link 1](http://akanto.wordpress.com/2012/09/25/cross-compiling-kernel-for-raspberry-pi-on-fedora-17-part-1)
 * [link 2](http://wiki.gentoo.org/wiki/Raspberry_Pi)

## References

* http://coreos.com
* http://www.stockwith.uklinux.net/hints
