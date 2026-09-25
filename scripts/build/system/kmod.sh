VERSION=${VERSION-34.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/kmod/$VERSION/kmod-$VERSION.tar.xz"\
    "https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-$VERSION.tar.xz"
rm -rf kmod-$VERSION && tar -Jxf "kmod-$VERSION.tar.xz"
rm -f "kmod-$VERSION.tar.xz"
cd kmod-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --sysconfdir=/etc\
    --disable-manpages\
    --with-xz\
    --with-zlib

make
test $TEST && make check
make install

ln -svf kmod /usr/bin/lsmod
