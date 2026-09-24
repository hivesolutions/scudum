VERSION=${VERSION-2.10.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/kbd/$VERSION/kbd-$VERSION.tar.xz"\
    "https://www.kernel.org/pub/linux/utils/kbd/kbd-$VERSION.tar.xz"
rm -rf kbd-$VERSION && tar -Jxf "kbd-$VERSION.tar.xz"
rm -f "kbd-$VERSION.tar.xz"
cd kbd-$VERSION

rgeti "https://mirrors.hive.pt/mirrors/scudum/kbd/$VERSION/kbd-$VERSION-backspace-1.patch"\
    "https://www.linuxfromscratch.org/patches/lfs/13.1/kbd-$VERSION-backspace-1.patch"
patch -Np1 -i kbd-$VERSION-backspace-1.patch

sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

./configure --host=$ARCH_TARGET --prefix=/usr --disable-vlock

make && make install
