VERSION=${VERSION-1.47.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://ftp.gnu.org/gnu/help2man/help2man-$VERSION.tar.xz"
rm -rf help2man-$VERSION && tar -Jxf "help2man-$VERSION.tar.xz"
rm -f "help2man-$VERSION.tar.gz"
cd help2man-$VERSION

./configure --prefix=$PREFIX
make && make install
