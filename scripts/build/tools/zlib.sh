VERSION=${VERSION-1.3.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/zlib/$VERSION/zlib-$VERSION.tar.gz"\
    "https://zlib.net/fossils/zlib-$VERSION.tar.gz"
rm -rf zlib-$VERSION && tar -zxf "zlib-$VERSION.tar.gz"
rm -f "zlib-$VERSION.tar.gz"
cd zlib-$VERSION

./configure --prefix=/usr

make && make install

rm -fv /usr/lib/libz.a
