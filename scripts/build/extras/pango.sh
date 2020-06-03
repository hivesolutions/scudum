VERSION=${VERSION-1.36.8}
VERSION_L=${VERSION_L-1.36}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "cairo" "harfbuzz" "fontconfig"

wget --content-disposition "http://ftp.gnome.org/pub/gnome/sources/pango/$VERSION_L/pango-$VERSION.tar.xz"
rm -rf pango-$VERSION && tar -Jxf "pango-$VERSION.tar.xz"
rm -f "pango-$VERSION.tar.xz"
cd pango-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
