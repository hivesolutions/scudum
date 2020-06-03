VERSION=${VERSION-1.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "mesa" "xorg-macros"

wget --content-disposition "http://crux.nu/files/libepoxy-$VERSION.tar.gz"
rm -rf libepoxy-$VERSION && tar -zxf "libepoxy-$VERSION.tar.gz"
rm -f "libepoxy-$VERSION.tar.gz"
cd libepoxy-$VERSION

./autogen.sh --prefix=$PREFIX
make && make install
