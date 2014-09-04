VERSION=${VERSION-3.00}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/cdrtools/cdrtools-$VERSION.tar.gz"
rm -rf cdrtools-$VERSION && tar -zxf "cdrtools-$VERSION.tar.gz"
rm -f "cdrtools-$VERSION.tar.gz"
cd cdrtools-$VERSION

./configure --prefix=$PREFIX
make && make install
