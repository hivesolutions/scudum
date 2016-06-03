VERSION=${VERSION-11.2.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-libs" "libdrm" "python" "expat" "libva" "libvdpau"

wget "ftp://ftp.freedesktop.org/pub/mesa/$VERSION/mesa-$VERSION.tar.bz2"
rm -rf mesa-$VERSION && tar -jxf "mesa-$VERSION.tar.bz2"
rm -f "mesa-$VERSION.tar.bz2"
cd mesa-$VERSION

autoreconf -f -i

./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --enable-texture-float\
    --enable-gles1\
    --enable-gles2\
    --enable-osmesa\
    --enable-va\
    --enable-vdpau\
    --enable-xa\
    --enable-gbm\
    --enable-glx-tls\
    --with-egl-platforms="drm,x11"\
    --with-gallium-drivers="nouveau,i915,ilo,svga,swrast"

make && make install
