VERSION=${VERSION-1.33.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://github.com/aria2/aria2/releases/download/release-$VERSION/aria2-$VERSION.tar.gz"
rm -rf aria2-$VERSION && tar -zxf "aria2-$VERSION.tar.gz"
rm -f "aria2-$VERSION.tar.gz"
cd aria2-$VERSION

./configure --prefix=$PREFIX
make && make install
