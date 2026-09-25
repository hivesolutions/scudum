VERSION=${VERSION-1.35}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/tar/$VERSION/tar-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/tar/tar-$VERSION.tar.xz"
rm -rf tar-$VERSION && tar -Jxf "tar-$VERSION.tar.xz"
rm -f "tar-$VERSION.tar.xz"
cd tar-$VERSION

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(build-aux/config.guess)

make && make DESTDIR=$SCUDUM install
