VERSION=${VERSION-0.5.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "gtk+2"

wget "http://downloads.sourceforge.net/lxde/lxde-icon-theme-$VERSION.tar.xz"
rm -rf xde-icon-theme-$VERSION && tar -Jxf "lxde-icon-theme-$VERSION.tar.xz"
rm -f "lxde-icon-theme-$VERSION.tar.xz"
cd lxde-icon-theme-$VERSION

./configure --prefix=$PREFIX
make && make install

gtk-update-icon-cache -qf $PREFIX/share/icons/nuoveXT2
