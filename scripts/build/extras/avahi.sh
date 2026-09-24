VERSION=${VERSION-0.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat" "glib" "libdaemon"

rget "https://mirrors.hive.pt/mirrors/scudum/avahi/$VERSION/avahi-$VERSION.tar.gz"\
    "https://github.com/avahi/avahi/releases/download/v$VERSION/avahi-$VERSION.tar.gz"
rm -rf avahi-$VERSION && tar -zxf "avahi-$VERSION.tar.gz"
rm -f "avahi-$VERSION.tar.gz"
cd avahi-$VERSION

./configure\
    --prefix=$PREFIX\
    --with-distro=none\
    --disable-qt3\
    --disable-qt4\
    --disable-qt5\
    --disable-gtk\
    --disable-gtk3\
    --disable-dbus\
    --disable-libevent\
    --disable-mono\
    --disable-python\
    --disable-pygobject

make && make install

useradd avahi
