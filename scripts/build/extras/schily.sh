VERSION=${VERSION-2014-06-12}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/schilytools/schily-$VERSION.tar.bz2"
rm -rf schily-$VERSION && tar -jxf "schily-$VERSION.tar.bz2"
rm -f "schily-$VERSION.tar.bz2"
cd schily-$VERSION

./configure --prefix=$PREFIX
make && make install
