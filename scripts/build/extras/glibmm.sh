VERSION=${VERSION-2.42.0}
VERSION_L=${VERSION_L-2.42}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glib" "libsigc++"

wget "ftp://ftp.gnome.org/pub/gnome/sources/glibmm/$VERSION_L/glibmm-$VERSION.tar.xz"
rm -rf glibmm-$VERSION && tar -Jxf "glibmm-$VERSION.tar.xz"
rm -f "glibmm-$VERSION.tar.xz"
cd glibmm-$VERSION

./configure --prefix=$PREFIX
make && make install
