VERSION=${VERSION-10.3.0}
VERSION_L=${VERSION_L-10.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-libs" "libdrm" "python" "expat"

wget "ftp://ftp.freedesktop.org/pub/mesa/$VERSION_L/MesaLib-$VERSION.tar.bz2"
rm -rf Mesa-$VERSION && tar -jxf "MesaLib-$VERSION.tar.bz2"
rm -f "MesaLib-$VERSION.tar.bz2"
cd Mesa-$VERSION

./autogen.sh\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --enable-texture-float\
    --enable-gles1\
    --enable-gles2\
    --enable-openvg\
    --enable-osmesa\
    --enable-xa\
    --enable-gbm\
    --enable-gallium-egl\
    --enable-gallium-gbm\
    --enable-glx-tls\
    --with-egl-platforms="drm,x11"\
    --with-gallium-drivers="nouveau,i915,ilo,svga,swrast"

make && make install
