VERSION=${VERSION-0.9.0}

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
    --disable-documentation\
    --disable-gdm-transition\
    --enable-pango\
	--enable-static\
    --enable-tracing\
    --enable-gtk\
    --enable-drm\
    --with-system-root-install\
    --without-rhgb-compat-link\
    --with-boot-tty=/dev/tty7\
    --with-shutdown-tty=/dev/tty7

make && make install

cat > /etc/plymouth/plymouthd.conf << "EOF"
[Daemon]
Theme=spinner
ShowDelay=0
EOF
