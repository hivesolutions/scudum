VERSION=${VERSION-1.12.16}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libpng" "freetype" "pixman"

export CFLAGS="$CFLAGS -fpic"

wget "http://cairographics.org/releases/cairo-$VERSION.tar.xz"
rm -rf cairo-$VERSION && tar -Jxf "cairo-$VERSION.tar.xz"
rm -f "cairo-$VERSION.tar.xz"
cd cairo-$VERSION

./configure\
    --prefix=$PREFIX\
    --disable-static\
    --enable-tee

make && make install
