[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-2.33}
VERSION_MAJOR=${VERSION_MAJOR-2.33}

set -e +h

wget --content-disposition "http://www.kernel.org/pub/linux/utils/util-linux/v$VERSION_MAJOR/util-linux-$VERSION.tar.xz"
rm -rf util-linux-$VERSION && tar -Jxf "util-linux-$VERSION.tar.xz"
rm -f "util-linux-$VERSION.tar.xz"
cd util-linux-$VERSION

mkdir -pv /var/lib/hwclock

./configure\
    --prefix=$PREFIX\
    --disable-chfn-chsh\
    --disable-login\
    --disable-nologin\
    --disable-su\
    --disable-setpriv\
    --disable-runuser\
    --disable-pylibmount\
    --without-python\
    --without-systemd\
    --without-systemdsystemunitdir

make && make install
