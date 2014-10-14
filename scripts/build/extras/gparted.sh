VERSION=${VERSION-0.19.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "parted" "gtkmm"

wget "http://downloads.sourceforge.net/gparted/gparted-$VERSION.tar.bz2"
rm -rf gparted-$VERSION && tar -jxf "gparted-$VERSION.tar.bz2"
rm -f "gparted-$VERSION.tar.bz2"
cd gparted-$VERSION

./configure --prefix=$PREFIX --disable-doc --disable-static
make && make install
