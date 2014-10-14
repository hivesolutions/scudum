VERSION=${VERSION-1.12.16}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libpng" "freetype" "pixman" "glib" "fontconfig" "xorg-libs" "mesa" "libdrm"

wget "http://cairographics.org/releases/cairo-$VERSION.tar.xz"
rm -rf cairo-$VERSION && tar -Jxf "cairo-$VERSION.tar.xz"
rm -f "cairo-$VERSION.tar.xz"
cd cairo-$VERSION

./configure\
    --prefix=$PREFIX\
    --disable-static\
    --enable-tee\
    --enable-drm\
    --enable-gl\
    --enable-glesv2

make && make install
