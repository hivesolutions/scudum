VERSION=${VERSION-1.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

wget --content-disposition "http://www.freedesktop.org/software/libevdev/libevdev-$VERSION.tar.xz"
rm -rf libevdev-$VERSION && tar -Jxf "libevdev-$VERSION.tar.xz"
rm -f "libevdev-$VERSION.tar.xz"
cd libevdev-$VERSION

./configure --prefix=$PREFIX
make && make install
