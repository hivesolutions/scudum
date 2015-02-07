VERSION=${VERSION-1.18}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-$VERSION.tar.bz2"
rm -rf libgpg-error-$VERSION && tar -jxf "libgpg-error-$VERSION.tar.bz2"
rm -f "libgpg-error-$VERSION.tar.bz2"
cd libgpg-error-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
