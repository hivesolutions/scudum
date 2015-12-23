VERSION=${VERSION-208}
VERSION_L=${VERSION_L-208-3}

set -e +h

wget --no-check-certificate "http://www.freedesktop.org/software/systemd/systemd-$VERSION.tar.xz"
rm -rf systemd-$VERSION && tar -Jxf "systemd-$VERSION.tar.xz"
cd systemd-$VERSION

wget --no-check-certificate "http://archive.hive.pt/extra/files/udev-lfs-$VERSION_L.tar.bz2"
rm -rf udev-lfs-$VERSION_L && tar -jxf udev-lfs-$VERSION_L.tar.bz2
rm -f udev-lfs-$VERSION_L.tar.bz2

if [ "$SCUDUM_CROSS" == "1" ]; then
    SHELL="/bin/sh"
    VB="arm-rasp-linux-gnueabi-"
    OPTIONS="$LDFLAGS -O2 -pipe -ffast-math -fno-common -fdiagnostics-show-option -fno-strict-aliasing -ffunction-sections -fdata-sections -fPIC -std=gnu99"
    LDFLAGS2="$LDFLAGS -pthread -lrt -Wl,--as-needed -Wl,--gc-sections -Wl,--no-undefined -lblkid -lkmod -lz -llzma -luuid"
    make -f udev-lfs-$VERSION_L/Makefile.lfs SHELL="$SHELL" VB="$VB" OPTIONS="$OPTIONS" LDFLAGS2="$LDFLAGS2"
    make -f udev-lfs-$VERSION_L/Makefile.lfs SHELL="$SHELL" VB="$VB" OPTIONS="$OPTIONS" LDFLAGS2="$LDFLAGS2" install
else
    make -f udev-lfs-$VERSION_L/Makefile.lfs
    make -f udev-lfs-$VERSION_L/Makefile.lfs install

    build/udevadm hwdb --update
    bash udev-lfs-$VERSION_L/init-net-rules.sh
fi
