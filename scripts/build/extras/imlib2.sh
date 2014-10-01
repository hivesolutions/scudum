VERSION=${VERSION-1.4.6}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/enlightenment/imlib2-$VERSION.tar.gz"
rm -rf imlib2-$VERSION && tar -zxf "imlib2-$VERSION.tar.gz"
rm -f "imlib2-$VERSION.tar.gz"
cd imlib2-$VERSION

./configure --prefix=$PREFIX
make && make install
