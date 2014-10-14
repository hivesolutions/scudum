VERSION=${VERSION-2.22.7}
VERSION_L=${VERSION_L-2.22}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "atk" "glibmm"

wget "http://ftp.gnome.org/pub/gnome/sources/atkmm/$VERSION_L/atkmm-$VERSION.tar.xz"
rm -rf atkmm-$VERSION && tar -Jxf "atkmm-$VERSION.tar.xz"
rm -f "atkmm-$VERSION.tar.xz"
cd atkmm-$VERSION

./configure --prefix=$PREFIX
make && make install
