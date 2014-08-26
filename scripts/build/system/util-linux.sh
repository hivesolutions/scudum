VERSION=${VERSION-2.22.2}

set -e

wget --no-check-certificate "http://www.kernel.org/pub/linux/utils/util-linux/v2.22/util-linux-$VERSION.tar.xz"
rm -rf util-linux-$VERSION && tar -Jxf "util-linux-$VERSION.tar.xz"
rm -f "util-linux-$VERSION.tar.xz"
cd util-linux-$VERSION

sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g'\
    $(grep -rl '/etc/adjtime' .)
mkdir -pv /var/lib/hwclock

./configure --disable-su --disable-sulogin --disable-login

make && make install
