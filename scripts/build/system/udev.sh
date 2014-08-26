VERSION="197"
VERSION_L="197-2"

wget --no-check-certificate http://anduin.linuxfromscratch.org/sources/other/udev-lfs-$VERSION_L.tar.bz2
rm -rf systemd-$VERSION && tar -Jxf "systemd-$VERSION.tar.xz"
rm -f "systemd-$VERSION.tar.xz"
cd systemd-$VERSION

tar -zxf ../udev-lfs-$VERSION_L.tar.bz2

make -f udev-lfs-$VERSION_L/Makefile.lfs
make -f udev-lfs-$VERSION_L/Makefile.lfs install

build/udevadm hwdb --update

bash udev-lfs-$VERSION_L/init-net-rules.sh
