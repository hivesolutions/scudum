VERSION=${VERSION-1.1.0-rc3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xmlto" "lynx" "xorg-applications"

wget "http://people.freedesktop.org/~rdieter/xdg-utils/xdg-utils-$VERSION.tar.gz"
rm -rf xdg-utils-$VERSION && tar -zxf "xdg-utils-$VERSION.tar.gz"
rm -f "xdg-utils-$VERSION.tar.gz"
cd xdg-utils-$VERSION

./configure --prefix=$PREFIX --mandir=$PREFIX/share/man
make && make install
