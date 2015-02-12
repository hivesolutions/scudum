VERSION_EVDEV=${VERSION_EVDEV-2.9.0}
VERSION_SYNAPTICS=${VERSION_SYNAPTICS-1.8.1}
VERSION_VESA=${VERSION_VESA-2.3.3}
VERSION_FBDEV=${VERSION_FBDEV-0.4.4}
VERSION_NOUVEAU=${VERSION_NOUVEAU-1.0.11}
VERSION_INTEL=${VERSION_INTEL-2.99.917}
VERSION_VMWARE=${VERSION_VMWARE-13.1.0}
VERSION_INTELVA=${VERSION_INTELVA-1.4.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libevdev" "libva" "xorg-server"

wget "http://xorg.freedesktop.org/archive/individual/driver/xf86-input-evdev-$VERSION_EVDEV.tar.bz2"
rm -rf xf86-input-evdev-$VERSION_EVDEV && tar -jxf "xf86-input-evdev-$VERSION_EVDEV.tar.bz2"
rm -f "xf86-input-evdev-$VERSION_EVDEV.tar.bz2"
cd xf86-input-evdev-$VERSION_EVDEV

./configure --prefix=$PREFIX
make && make install

cd ..

wget "http://xorg.freedesktop.org/archive/individual/driver/xf86-input-synaptics-$VERSION_SYNAPTICS.tar.bz2"
rm -rf xf86-input-synaptics-$VERSION_SYNAPTICS && tar -jxf "xf86-input-synaptics-$VERSION_SYNAPTICS.tar.bz2"
rm -f "xf86-input-synaptics-$VERSION_SYNAPTICS.tar.bz2"
cd xf86-input-synaptics-$VERSION_SYNAPTICS

./configure --prefix=$PREFIX
make && make install

cd ..

wget "http://xorg.freedesktop.org/archive/individual/driver/xf86-video-vesa-$VERSION_VESA.tar.bz2"
rm -rf xf86-video-vesa-$VERSION_VESA && tar -jxf "xf86-video-vesa-$VERSION_VESA.tar.bz2"
rm -f "xf86-video-vesa-$VERSION_VESA.tar.bz2"
cd xf86-video-vesa-$VERSION_VESA

./configure --prefix=$PREFIX
make && make install

cd ..

wget "http://xorg.freedesktop.org/archive/individual/driver/xf86-video-fbdev-$VERSION_FBDEV.tar.bz2"
rm -rf xf86-video-fbdev-$VERSION_FBDEV && tar -jxf "xf86-video-fbdev-$VERSION_FBDEV.tar.bz2"
rm -f "xf86-video-fbdev-$VERSION_FBDEV.tar.bz2"
cd xf86-video-fbdev-$VERSION_FBDEV

./configure --prefix=$PREFIX
make && make install

cd ..

wget "http://xorg.freedesktop.org/archive/individual/driver/xf86-video-nouveau-$VERSION_NOUVEAU.tar.bz2"
rm -rf xf86-video-nouveau-$VERSION_NOUVEAU && tar -jxf "xf86-video-nouveau-$VERSION_NOUVEAU.tar.bz2"
rm -f "xf86-video-nouveau-$VERSION_NOUVEAU.tar.bz2"
cd xf86-video-nouveau-$VERSION_NOUVEAU

./configure --prefix=$PREFIX
make && make install

cd ..

wget "http://xorg.freedesktop.org/archive/individual/driver/xf86-video-intel-$VERSION_INTEL.tar.bz2"
rm -rf xf86-video-intel-$VERSION_INTEL && tar -jxf "xf86-video-intel-$VERSION_INTEL.tar.bz2"
rm -f "xf86-video-intel-$VERSION_INTEL.tar.bz2"
cd xf86-video-intel-$VERSION_INTEL

./configure --prefix=$PREFIX
make && make install

cd ..

wget "http://xorg.freedesktop.org/archive/individual/driver/xf86-video-vmware-$VERSION_VMWARE.tar.bz2"
rm -rf xf86-video-vmware-$VERSION_VMWARE && tar -jxf "xf86-video-vmware-$VERSION_VMWARE.tar.bz2"
rm -f "xf86-video-vmware-$VERSION_VMWARE.tar.bz2"
cd xf86-video-vmware-$VERSION_VMWARE

./configure --prefix=$PREFIX
make && make install

cd ..

wget "http://www.freedesktop.org/software/vaapi/releases/libva-intel-driver/libva-intel-driver-$VERSION_INTELVA.tar.bz2"
rm -rf libva-intel-driver-$VERSION_INTELVA && tar -jxf "libva-intel-driver-$VERSION_INTELVA.tar.bz2"
rm -f "libva-intel-driver-$VERSION_INTELVA.tar.bz2"
cd libva-intel-driver-$VERSION_INTELVA

mkdir -p m4 && autoreconf -f
./configure --prefix=$PREFIX
make && make install
