VERSION=${VERSION-6.02}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-$VERSION.tar.xz"
rm -rf syslinux-$VERSION && tar -Jxf "syslinux-$VERSION.tar.xz"
rm -f "syslinux-$VERSION.tar.xz"
cd syslinux-$VERSION

./configure --prefix=$PREFIX
make && make install
