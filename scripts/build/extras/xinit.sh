VERSION=${VERSION-1.3.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-server" "xorg-drivers" "xterm" "xclock" "twm"

wget --content-disposition "http://xorg.freedesktop.org/releases/individual/app/xinit-$VERSION.tar.bz2"
rm -rf xinit-$VERSION && tar -jxf "xinit-$VERSION.tar.bz2"
rm -f "xinit-$VERSION.tar.bz2"
cd xinit-$VERSION

./configure --prefix=$PREFIX --with-xinitdir=/etc/X11/app-defaults
make && make install
