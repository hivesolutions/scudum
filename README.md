# Scudum

A simple Linux distribution for usage in colony, viriatum and tiberium distributed solutions.

The distribution is meant to provide a simple raw system that should be configured from
configuration servers that are discoverable using auto-discover techniques (Zeroconf, etc).
Using scudum one could build an army of servers that are configurable from a single instance
so that replacing them is easy and cheap (without human intervention).

## Objectives

* Viriatum based web interface for configuration (scu installation and more)
* RAM only operative system (not required but objective)
* Easy auto configuration (Zeroconf and centralized server)
* Fast boot (< 10 sec)
* Low - Medium RAM usage (< 1 GB)

## Installation

TODO

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
