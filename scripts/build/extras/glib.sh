VERSION=${VERSION-2.88.3}
VERSION_L=${VERSION_L-2.88}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "meson" "libffi" "python" "pcre2"

rget "https://mirrors.hive.pt/mirrors/scudum/glib/$VERSION/glib-$VERSION.tar.xz"\
    "http://ftp.gnome.org/pub/gnome/sources/glib/$VERSION_L/glib-$VERSION.tar.xz"
rm -rf glib-$VERSION && tar -Jxf "glib-$VERSION.tar.xz"
rm -f "glib-$VERSION.tar.xz"
cd glib-$VERSION

meson setup _build\
    --prefix=$PREFIX\
    --libdir=lib\
    --buildtype=release\
    --wrap-mode=nodownload\
    -Dselinux=disabled\
    -Dsysprof=disabled\
    -Dglib_debug=disabled\
    -Dtests=false
ninja -C _build && ninja -C _build install
