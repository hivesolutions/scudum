VERSION=${VERSION-2.42.2}
VERSION_MAJOR=${VERSION_MAJOR-2.42}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/util-linux/$VERSION/util-linux-$VERSION.tar.xz"\
    "https://www.kernel.org/pub/linux/utils/util-linux/v$VERSION_MAJOR/util-linux-$VERSION.tar.xz"
rm -rf util-linux-$VERSION && tar -Jxf "util-linux-$VERSION.tar.xz"
rm -f "util-linux-$VERSION.tar.xz"
cd util-linux-$VERSION

mkdir -pv /var/lib/hwclock

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime\
    --host=$ARCH_TARGET\
    --bindir=/usr/bin\
    --libdir=/usr/lib\
    --runstatedir=/run\
    --sbindir=/usr/sbin\
    --docdir=/usr/share/doc/util-linux-$VERSION\
    --disable-chfn-chsh\
    --disable-login\
    --disable-nologin\
    --disable-su\
    --disable-setpriv\
    --disable-runuser\
    --disable-pylibmount\
    --disable-liblastlog2\
    --disable-static\
    --without-python\
    --without-systemd\
    --without-systemdsystemunitdir

make && make install
