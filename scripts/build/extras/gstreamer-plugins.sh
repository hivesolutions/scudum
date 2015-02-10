VERSION=${VERSION-1.4.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gstreamer" "pango" "alsa" "libogg" "libtheora" "libvorbis"

wget "http://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-$VERSION.tar.xz"
rm -rf gst-plugins-base-$VERSION && tar -Jxf "gst-plugins-base-$VERSION.tar.xz"
rm -f "gst-plugins-base-$VERSION.tar.xz"
cd gst-plugins-base-$VERSION

./configure --prefix=$PREFIX
make && make install

wget "http://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-$VERSION.tar.xz"
rm -rf gst-plugins-good-$VERSION && tar -Jxf "gst-plugins-good-$VERSION.tar.xz"
rm -f "gst-plugins-good-$VERSION.tar.xz"
cd gst-plugins-good-$VERSION

./configure --prefix=$PREFIX
make && make install
