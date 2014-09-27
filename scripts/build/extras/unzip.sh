VERSION=${VERSION-60}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/infozip/unzip$VERSION.tar.gz"
rm -rf unzip$VERSION && tar -zxf "unzip$VERSION.tar.gz"
rm -f "unzip$VERSION.tar.gz"
cd unzip$VERSION

./configure --prefix=$PREFIX
make && make install
