VERSION=${VERSION-2.4.47}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://download.savannah.gnu.org/releases/attr/attr-$VERSION.src.tar.gz"
rm -rf attr-$VERSION && tar -zxf "attr-$VERSION.src.tar.gz"
rm -f "attr-$VERSION.src.tar.gz"
cd attr-$VERSION

./configure --prefix=$PREFIX
make && make install install-dev install-lib
