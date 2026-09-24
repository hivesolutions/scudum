VERSION=${VERSION-1.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/gzip/$VERSION/gzip-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gzip/gzip-$VERSION.tar.xz"
rm -rf gzip-$VERSION && tar -Jxf "gzip-$VERSION.tar.xz"
rm -f "gzip-$VERSION.tar.xz"
cd gzip-$VERSION

./configure --prefix=/usr --host=$SCUDUM_TARGET
make && make DESTDIR=$SCUDUM install
