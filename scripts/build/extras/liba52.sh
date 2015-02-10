VERSION=${VERSION-0.7.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

export CFLAGS="$CFLAGS -fPIC"

rget "http://liba52.sourceforge.net/files/a52dec-$VERSION.tar.gz"\
    "ftp://ftp.fi.debian.org/gentoo/distfiles/a52dec-$VERSION.tar.gz"
rm -rf a52dec-$VERSION && tar -zxf "a52dec-$VERSION.tar.gz"
rm -f "a52dec-$VERSION.tar.gz"
cd a52dec-$VERSION

./configure\
    --prefix=$PREFIX\
    --mandir=$PREFIX/share/man\
    --enable-shared\
    --disable-static

make && make install
