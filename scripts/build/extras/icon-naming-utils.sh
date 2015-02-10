VERSION=${VERSION-0.8.90}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://tango.freedesktop.org/releases/icon-naming-utils-$VERSION.tar.bz2"
rm -rf icon-naming-utils-$VERSION && tar -jxf "icon-naming-utils-$VERSION.tar.bz22"
rm -f "icon-naming-utils-$VERSION.tar.bz2"
cd icon-naming-utils-$VERSION

./configure --prefix=$PREFIX
make && make install
