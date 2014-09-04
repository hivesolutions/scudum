VERSION=${VERSION-3.00}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "schily"

wget "http://prdownloads.sourceforge.net/cdrtools/cdrtools-$VERSION.tar.gz"
rm -rf cdrtools-$VERSION && tar -zxf "cdrtools-$VERSION.tar.gz"
rm -f "cdrtools-$VERSION.tar.gz"
cd cdrtools-$VERSION

make && PREFIX=$PREFIX DEFMANBASE=. make install
