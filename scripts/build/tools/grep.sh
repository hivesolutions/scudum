VERSION=${VERSION-3.12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/grep/$VERSION/grep-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/grep/grep-$VERSION.tar.xz"
rm -rf grep-$VERSION && tar -Jxf "grep-$VERSION.tar.xz"
rm -f "grep-$VERSION.tar.xz"
cd grep-$VERSION

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(./build-aux/config.guess)

make && make DESTDIR=$SCUDUM install
