VERSION=${VERSION-1.4.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://storage.googleapis.com/golang/go$VERSION.src.tar.gz"
rm -rf go && tar -zxf "go$VERSION.src.tar.gz"
rm -f "go$VERSION.src.tar.gz"
rm -rf $PREFIX/go && mv go $PREFIX && cd $PREFIX/go/src

./all.bash

mkdir -pv $PREFIX/bin

ln -svf ../go/bin/go $PREFIX/bin/go
ln -svf ../go/bin/gofmt $PREFIX/bin/gofmt
