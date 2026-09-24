VERSION=${VERSION-2.15}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/cpio/$VERSION/cpio-$VERSION.tar.bz2"\
    "https://ftpmirror.gnu.org/cpio/cpio-$VERSION.tar.bz2"
rm -rf cpio-$VERSION && tar -jxf "cpio-$VERSION.tar.bz2"
rm -f "cpio-$VERSION.tar.bz2"
cd cpio-$VERSION

sed -e "/^extern int (\*xstat)/s/()/(const char * restrict,  struct stat * restrict)/"\
    -i src/extern.h
sed -e "/^int (\*xstat)/s/()/(const char * restrict,  struct stat * restrict)/"\
    -i src/global.c

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --enable-mt\
    --with-rmt=/usr/libexec/rmt

make && make install
