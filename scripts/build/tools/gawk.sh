VERSION=${VERSION-5.4.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/gawk/$VERSION/gawk-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gawk/gawk-$VERSION.tar.xz"
rm -rf gawk-$VERSION && tar -Jxf "gawk-$VERSION.tar.xz"
rm -f "gawk-$VERSION.tar.xz"
cd gawk-$VERSION

sed -i 's/extras//' Makefile.in

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(build-aux/config.guess)

make && make DESTDIR=$SCUDUM install
