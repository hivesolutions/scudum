VERSION=${VERSION-1.3.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

wget "http://www.tortall.net/projects/yasm/releases/yasm-$VERSION.tar.gz"
rm -rf yasm-$VERSION && tar -zxf "yasm-$VERSION.tar.gz"
rm -f "yasm-$VERSION.tar.gz"
cd yasm-$VERSION

./configure --prefix=$PREFIX
make && make install
