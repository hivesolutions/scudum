VERSION=${VERSION-1.6.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libgpg-error"

wget "ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-$VERSION.tar.bz2"
rm -rf libgcrypt-$VERSION && tar -jxf "libgcrypt-$VERSION.tar.bz2"
rm -f "libgcrypt-$VERSION.tar.bz2"
cd libgcrypt-$VERSION

./configure --prefix=$PREFIX
make && make install
