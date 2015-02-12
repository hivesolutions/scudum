VERSION=${VERSION-2.02~beta2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

unset CFLAGS

wget "http://alpha.gnu.org/gnu/grub/grub-$VERSION.tar.gz"
rm -rf grub-$VERSION && tar -zxf "grub-$VERSION.tar.gz"
rm -f "grub-$VERSION.tar.gz"
cd grub-$VERSION

./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --with-platform=efi\
    --target=x86_64\
    --disable-werror

make && make install
