VERSION_EVDEV=${VERSION_EVDEV-2.9.0}
VERSION_SYNAPTICS-=${VERSION_SYNAPTICS-1.8.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libevdev" "xorg-server"

wget "http://xorg.freedesktop.org/archive/individual/driver/xf86-input-evdev-$VERSION_EVDEV.tar.bz2"
rm -rf xf86-input-evdev-$VERSION_EVDEV && tar -jxf "xf86-input-evdev-$VERSION_EVDEV.tar.bz2"
rm -f "xf86-input-evdev-$VERSION_EVDEV.tar.bz2"
cd xf86-input-evdev-$VERSION_EVDEV

./configure --prefix=$PREFIX
make && make install

wget "http://xorg.freedesktop.org/archive/individual/driver/xf86-input-synaptics-$VERSION_SYNAPTICS.tar.bz2"
rm -rf xf86-input-synaptics-$VERSION_SYNAPTICS && tar -jxf "xf86-input-synaptics-$VERSION_SYNAPTICS.tar.bz2"
rm -f "xf86-input-synaptics-$VERSION_SYNAPTICS.tar.bz2"
cd xf86-input-synaptics-$VERSION_SYNAPTICS

./configure --prefix=$PREFIX
make && make install
