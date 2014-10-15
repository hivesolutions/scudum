VERSION=${VERSION-2.30.7}
VERSION_L=${VERSION_L-2.30}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gtk+2"

wget "http://ftp.gnome.org/pub/gnome/sources/libwnck/$VERSION_L/libwnck-$VERSION.tar.xz"
rm -rf libwnck-$VERSION && tar -Jxf "libwnck-$VERSION.tar.xz"
rm -f "libwnck-$VERSION_L.tar.xz"
cd libwnck-$VERSION

./configure --prefix=$PREFIX --program-suffix=-1 --disable-static
make GETTEXT_PACKAGE=libwnck-1 && make GETTEXT_PACKAGE=libwnck-1 install
