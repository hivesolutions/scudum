VERSION=${VERSION-0.8.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libpng" "pango" "gtk+2" "libdrm"

wget "http://www.freedesktop.org/software/plymouth/releases/plymouth-$VERSION.tar.bz2"
rm -rf plymouth-$VERSION && tar -jxf "plymouth-$VERSION.tar.bz2"
rm -f "plymouth-$VERSION.tar.bz2"
cd plymouth-$VERSION

./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --disable-silent-rules\
    --disable-gdm-transition\
    --enable-pango\
    --enable-static\
    --enable-tracing\
    --enable-gtk\
    --enable-drm\
    --with-background-start-color-stop=0x0073b3\
    --with-background-end-color-stop=0x00457e\
    --with-background-color=0x3391cd\
    --with-logo=/usr/share/scudum/scudum-logo-white.png\
    --without-rhgb-compat-link\
    --with-boot-tty=/dev/tty1\
    --with-shutdown-tty=/dev/tty1

make && make install

cat > /etc/plymouth/plymouthd.conf << "EOF"
[Daemon]
Theme=fade-in
ShowDelay=0
EOF
