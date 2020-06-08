VERSION=${VERSION-2.58.3}
VERSION_L=${VERSION_L-2.58}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "meson" "cmake" "libffi" "python" "pcre"

wget --content-disposition "http://ftp.gnome.org/pub/gnome/sources/glib/$VERSION_L/glib-$VERSION.tar.xz"
rm -rf glib-$VERSION && tar -Jxf "glib-$VERSION.tar.xz"
rm -f "glib-$VERSION.tar.xz"
cd glib-$VERSION

meson _build -Druntime_libdir=$PREFIX -Dselinux=disabled
ninja -C _build && ninja -C _build install
