VERSION=${VERSION-4.4.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/make/$VERSION/make-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/make/make-$VERSION.tar.gz"
rm -rf make-$VERSION && tar -zxf "make-$VERSION.tar.gz"
rm -f "make-$VERSION.tar.gz"
cd make-$VERSION

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(build-aux/config.guess)

make && make DESTDIR=$SCUDUM install
