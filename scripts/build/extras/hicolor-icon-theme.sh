VERSION=${VERSION-0.13}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://icon-theme.freedesktop.org/releases/hicolor-icon-theme-$VERSION.tar.gz"
rm -rf hicolor-icon-theme-$VERSION && tar -zxf "hicolor-icon-theme-$VERSION.tar.gz"
rm -f "hicolor-icon-theme-$VERSION.tar.gz"
cd hicolor-icon-theme-$VERSION

./configure --prefix=$PREFIX
make install
