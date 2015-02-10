VERSION=${VERSION-1.4.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glib" "libxml2"

wget "http://gstreamer.freedesktop.org/src/gstreamer/gstreamer-$VERSION.tar.xz"
rm -rf gstreamer-$VERSION && tar -Jxf "gstreamer-$VERSION.tar.xz"
rm -f "gstreamer-$VERSION.tar.xz"
cd gstreamer-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
