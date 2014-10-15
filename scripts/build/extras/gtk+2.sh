VERSION=${VERSION-2.24.22}
VERSION_L=${VERSION_L-2.24}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "pango" "atk" "gdk-pixbuf" "xorg-libs" "hicolor-icon-theme"

wget "http://ftp.gnome.org/pub/gnome/sources/gtk+/$VERSION_L/gtk+-$VERSION.tar.xz"
rm -rf gtk+-$VERSION && tar -Jxf "gtk+-$VERSION.tar.xz"
rm -f "gtk+-$VERSION.tar.xz"
cd gtk+-$VERSION

sed -i 's#l \(gtk-.*\).sgml#& -o \1#' docs/{faq,tutorial}/Makefile.in
sed -i 's#.*@man_#man_#' docs/reference/gtk/Makefile.in
sed -i -e 's#pltcheck.sh#$(NULL)#g' gtk/Makefile.in

./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc

make && make install
