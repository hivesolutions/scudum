VERSION=${VERSION-1.3.1}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "https://storage.googleapis.com/golang/go$VERSION.src.tar.gz"
rm -rf go-$VERSION && tar -zxf "go-$VERSION.tar.gz"
rm -f "go-$VERSION.tar.gz"
cd go-$VERSION

./configure --prefix=$PREFIX
make && make install
