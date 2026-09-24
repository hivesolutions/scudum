VERSION=${VERSION-3.8.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://mirrors.hive.pt/mirrors/scudum/libffi/$VERSION/libffi-$VERSION.tar.gz"\
    "https://github.com/libffi/libffi/releases/download/v$VERSION/libffi-$VERSION.tar.gz"
rm -rf libffi-$VERSION && tar -zxf "libffi-$VERSION.tar.gz"
rm -f "libffi-$VERSION.tar.gz"
cd libffi-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
