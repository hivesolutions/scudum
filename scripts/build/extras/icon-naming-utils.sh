VERSION=${VERSION-0.8.90}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xml-simple"

wget --content-disposition "http://tango.freedesktop.org/releases/icon-naming-utils-$VERSION.tar.bz2"
rm -rf icon-naming-utils-$VERSION && tar -jxf "icon-naming-utils-$VERSION.tar.bz2"
rm -f "icon-naming-utils-$VERSION.tar.bz2"
cd icon-naming-utils-$VERSION

./configure --prefix=$PREFIX
make && make install
