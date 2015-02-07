VERSION=${VERSION-0.1.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/opencore-amr/fdk-aac-$VERSION.tar.gz"
rm -rf fdk-aac-$VERSION && tar -zxf "fdk-aac-$VERSION.tar.gz"
rm -f "fdk-aac-$VERSION.tar.gz"
cd fdk-aac-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
