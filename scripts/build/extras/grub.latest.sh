VERSION=${VERSION-2.00}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "http://ftp.gnu.org/gnu/grub/grub-$VERSION.tar.gz"
rm -rf grub-$VERSION && tar -zxf "grub-$VERSION.tar.gz"
rm -f "grub-$VERSION.tar.gz"
cd grub-$VERSION

sed -i -e '/gets is a/d' grub-core/gnulib/stdio.in.h

./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    -disable-werror

make && make install
