VERSION=${VERSION-2.74.3}
VERSION_L=${VERSION_L-2.74}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "meson" "libffi" "python" "pcre"

wget --content-disposition "http://ftp.gnome.org/pub/gnome/sources/glib/$VERSION_L/glib-$VERSION.tar.xz"
rm -rf glib-$VERSION && tar -Jxf "glib-$VERSION.tar.xz"
rm -f "glib-$VERSION.tar.xz"
cd glib-$VERSION

meson _build -Druntime_libdir=$PREFIX -Dselinux=false
ninja -C _build && ninja -C _build install
