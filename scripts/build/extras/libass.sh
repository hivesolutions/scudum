VERSION=${VERSION-0.12.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "freetype" "freebidi" "fontconfig"

wget "https://github.com/libass/libass/releases/download/$VERSION/libass-$VERSION.tar.xz"
rm -rf libass-$VERSION && tar -Jxf "libass-$VERSION.tar.xz"
rm -f "libass-$VERSION.tar.xz"
cd libass-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
