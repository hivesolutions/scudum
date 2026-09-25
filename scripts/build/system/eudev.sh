VERSION=${VERSION-3.2.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/eudev/$VERSION/eudev-$VERSION.tar.gz"\
    "https://github.com/eudev-project/eudev/releases/download/v$VERSION/eudev-$VERSION.tar.gz"
rm -rf eudev-$VERSION && tar -zxf "eudev-$VERSION.tar.gz"
rm -f "eudev-$VERSION.tar.gz"
cd eudev-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --bindir=/usr/sbin\
    --sysconfdir=/etc\
    --enable-manpages\
    --disable-static

make

mkdir -pv /usr/lib/udev/devices
mkdir -pv /usr/lib/udev/devices/pts
mkdir -pv /usr/lib/udev/rules.d
mkdir -pv /etc/udev/rules.d

make install

udevadm hwdb --update
