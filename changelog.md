# Changelog

## Version 27

* New lib directory for scudum `/lib/scudum`
* Version file for scudum `/lib/scudum/VERSION`

## Version 26

* Changed default [vesafs](http://en.wikipedia.org/wiki/VESA_BIOS_Extensions) mode to 791 (1024x768@16)

## Version 25

* Added htop (monitoring tool)
* Added nethogs (network monitoring tool)
* Included libpcap for network packet capture

### Version 24

* Support for libcurl
* Added support for https in git (using libcurl)
* Installed libexpat (for xml parsing)

### Version 23

* Changed kernel version to 3.12.x

### Version 22

* Support for autorun.inf and icon

### Version 21

* Fixed execution using the "normal" grub loading

### Version 20

* Small code cleanup

### Version 19

* lspci and lsusb utils added
* grep now in color auto on /etc/profile
* New network drivers added to kernel configuration

### Version 18

* Support for multicard readers in kernel
* Booting using usb drive enabled

### Version 17

* Optimized linux kernel

### Version 16

* New boot file templates

### Version 15

* Removed unused dev files

### Version 14

* Boot process optimization

### Version 13

* Optimized RAM usage by tempfs (all memory available is used for rootfs)

### Version 12

* Initial deployer added (scu)

### Version 11

* Which tool added
* DEB toolchain (dpkg) added (for scu generation)
* Support for checkinstall

### Version 10

* Inclusion of python interpreter
* Support for DHCP
* Created /scd directory for internal usage (added to PATH)

### Version 9

* First Live release
