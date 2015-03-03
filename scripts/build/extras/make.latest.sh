VERSION=${VERSION-4.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://ftp.gnu.org/gnu/make/make-$VERSION.tar.bz2"
rm -rf make-$VERSION && tar -jxf "make-$VERSION.tar.bz2"
rm -f "make-$VERSION.tar.bz2"
cd make-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
