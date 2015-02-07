VERSION=${VERSION-2.1.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "alsa" "ffmpeg" "liba52" "libgcrypt" "libmad" "x11"

wget "http://download.videolan.org/vlc/$VERSION/vlc-$VERSION.tar.xz"
rm -rf vlc-$VERSION && tar -Jxf "vlc-$VERSION.tar.xz"
rm -f "vlc-$VERSION.tar.xz"
cd vlc-$VERSION

./configure --prefix=$PREFIX --enable-run-as-root --disable-lua
make && make install
