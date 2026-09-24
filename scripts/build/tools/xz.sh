VERSION=${VERSION-5.8.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/xz/$VERSION/xz-$VERSION.tar.xz"\
    "https://github.com/tukaani-project/xz/releases/download/v$VERSION/xz-$VERSION.tar.xz"
rm -rf xz-$VERSION && tar -Jxf "xz-$VERSION.tar.xz"
rm -f "xz-$VERSION.tar.xz"
cd xz-$VERSION

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(build-aux/config.guess)\
    --disable-static\
    --docdir=/usr/share/doc/xz-$VERSION

make && make DESTDIR=$SCUDUM install

rm -v $SCUDUM/usr/lib/liblzma.la
