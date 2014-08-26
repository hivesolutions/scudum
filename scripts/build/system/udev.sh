VERSION=${VERSION-197}
VERSION_L=${VERSION_L-197-2}

set -e

wget --no-check-certificate "http://www.freedesktop.org/software/systemd/systemd-$VERSION.tar.xz"
rm -rf systemd-$VERSION && tar -Jxf "systemd-$VERSION.tar.xz"
cd systemd-$VERSION

wget --no-check-certificate "http://anduin.linuxfromscratch.org/sources/other/udev-lfs-$VERSION_L.tar.bz2"
rm -rf udev-lfs-$VERSION_L && tar -jxf udev-lfs-$VERSION_L.tar.bz2
rm -f udev-lfs-$VERSION_L.tar.bz2

make -f udev-lfs-$VERSION_L/Makefile.lfs
make -f udev-lfs-$VERSION_L/Makefile.lfs install

build/udevadm hwdb --update

bash udev-lfs-$VERSION_L/init-net-rules.sh
