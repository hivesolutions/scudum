VERSION=${VERSION-4.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/sed/$VERSION/sed-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/sed/sed-$VERSION.tar.xz"
rm -rf sed-$VERSION && tar -Jxf "sed-$VERSION.tar.xz"
rm -f "sed-$VERSION.tar.xz"
cd sed-$VERSION

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(./build-aux/config.guess)

make && make DESTDIR=$SCUDUM install
