VERSION=${VERSION-0.7}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "intltool" "glib" "libdaemon"

wget "https://github.com/lathiat/avahi/archive/v$VERSION.tar.gz"
rm -rf avahi-$VERSION && tar -zxf "v$VERSION.tar.gz"
rm -f "v$VERSION.tar.gz"
cd avahi-$VERSION

./configure\
    --prefix=$PREFIX\
    --with-distro=none\
    --disable-qt3\
    --disable-qt4\
    --disable-gtk\
    --disable-gtk3\
    --disable-dbus\
    --disable-pygobject

make && make install
