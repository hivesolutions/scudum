VERSION=${VERSION-0.17}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

wget "http://www.ex-parrot.com/~pdw/iftop/download/iftop-$VERSION.tar.gz"
rm -rf iftop-$VERSION && tar -zxf "iftop-$VERSION.tar.gz"
rm -f "iftop-$VERSION.tar.gz"
cd iftop-$VERSION

./configure --prefix=$PREFIX
make && make install
