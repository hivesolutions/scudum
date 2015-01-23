VERSION=${VERSION-2.00}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://ftp.gnu.org/gnu/grub/grub-$VERSION.tar.gz"
rm -rf grub-$VERSION && tar -zxf "grub-$VERSION.tar.gz"
rm -f "grub-$VERSION.tar.gz"
cd grub-$VERSION

unset CFLAGS

./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    -disable-werror

make && make install
