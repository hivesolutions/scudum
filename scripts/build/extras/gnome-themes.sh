VERSION=${VERSION-2.32.1}
VERSION_L=${VERSION_L-2.32}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gtk-engines"

wget "http://ftp.gnome.org/pub/gnome/sources/gnome-themes/$VERSION_L/gnome-themes-$VERSION.tar.bz2"
rm -rf gnome-themes-$VERSION && tar -jxf "gnome-themes-$VERSION.tar.bz2"
rm -f "gnome-themes-$VERSION.tar.bz2"
cd gnome-themes-$VERSION

./configure --prefix=$PREFIX
make && make install

cat > /etc/gtk-2.0/gtkrc << "EOF"
include "$PREFIX/share/themes/Clearlooks/gtk-2.0/gtkrc"
gtk-icon-theme-name = "elementary"
EOF
