VERSION=${VERSION-1.4.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gstreamer-plugins" "yasm"

wget "http://gstreamer.freedesktop.org/src/gst-libav/gst-libav-$VERSION.tar.xz"
rm -rf gst-libav-$VERSION && tar -Jxf "gst-libav-$VERSION.tar.xz"
rm -f "gst-libav-$VERSION.tar.xz"
cd gst-libav-$VERSION

./configure --prefix=$PREFIX
make && make install
