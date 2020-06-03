VERSION=${VERSION-0.7}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "intltool" "glib" "libdaemon"

wget --content-disposition "https://github.com/lathiat/avahi/releases/download/v$VERSION/avahi-$VERSION.tar.gz"
rm -rf avahi-$VERSION && tar -zxf "avahi-$VERSION.tar.gz"
rm -f "avahi-$VERSION.tar.gz"
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

useradd avahi
