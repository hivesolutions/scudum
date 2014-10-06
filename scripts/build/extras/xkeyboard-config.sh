VERSION=${VERSION-2.13}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "intltool" "xorg-libs"

wget "http://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-$VERSION.tar.bz2"
rm -rf xkeyboard-config-$VERSION && tar -jxf "xkeyboard-config-$VERSION.tar.bz2"
rm -f "xkeyboard-config-$VERSION.tar.bz2"
cd xkeyboard-config-$VERSION

./configure --prefix=$PREFIX --with-xkb-rules-symlink=xorg
make && make install
