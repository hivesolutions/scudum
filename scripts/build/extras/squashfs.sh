VERSION=${VERSION-4.3}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/squashfs/squashfs$VERSION.tar.gz"
rm -rf squashfs$VERSION && tar -zxf "squashfs$VERSION.tar.gz"
rm -f "squashfs$VERSION.tar.gz"
cd squashfs$VERSION

./configure --prefix=$PREFIX
make && make install
