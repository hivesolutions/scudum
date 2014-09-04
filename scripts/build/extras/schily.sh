VERSION=${VERSION-2014-06-12}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/schilytools/schily-$VERSION.tar.gz"
rm -rf schily-$VERSION && tar -zxf "schily-$VERSION.tar.gz"
rm -f "schily-$VERSION.tar.gz"
cd schily-$VERSION

./configure --prefix=$PREFIX
make && make install
