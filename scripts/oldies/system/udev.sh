VERSION="197"
VERSION_L="197-2"
tar -Jxf "systemd-197.tar.xz"
cd systemd-$VERSION

tar -zxf ../udev-lfs-$VERSION_L.tar.bz2

make -f udev-lfs-$VERSION_L/Makefile.lfs
make -f udev-lfs-$VERSION_L/Makefile.lfs install

build/udevadm hwdb --update

bash udev-lfs-$VERSION_L/init-net-rules.sh

cd ..
rm -rf systemd-$VERSION
