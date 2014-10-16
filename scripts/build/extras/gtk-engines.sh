VERSION=${VERSION-2.20.2}
VERSION_L=${VERSION_L-2.20}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gtk+2" "intltool" "lua"

wget "http://ftp.gnome.org/pub/gnome/sources/gtk-engines/$VERSION_L/gtk-engines-$VERSION.tar.bz2"
rm -rf gtk-engines-$VERSION && tar -jxf "gtk-engines-$VERSION.tar.bz2"
rm -f "gtk-engines-$VERSION.tar.bz2"
cd gtk-engines-$VERSION

./configure --prefix=$PREFIX --enable-lua
make && make install
