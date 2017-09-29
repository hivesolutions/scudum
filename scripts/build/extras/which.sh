VERSION=${VERSION-2.21}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://ftp.gnu.org/gnu/which/which-$VERSION.tar.gz"
rm -rf which-$VERSION && tar -zxf "which-$VERSION.tar.gz"
rm -f "which-$VERSION.tar.gz"
cd which-$VERSION

./configure --prefix=$PREFIX
make && make install
