VERSION=${VERSION-1.4.6}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-libs" "libpng" "jpeg-turbo" "tiff"

rget "http://downloads.sourceforge.net/enlightenment/imlib2-$VERSION.tar.bz2"\
    "ftp://ftp.kajak.org.pl/pub/distfiles/imlib2-$VERSION.tar.bz2"
rm -rf imlib2-$VERSION && tar -jxf "imlib2-$VERSION.tar.bz2"
rm -f "imlib2-$VERSION.tar.bz2"
cd imlib2-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
