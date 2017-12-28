VERSION=${VERSION-330}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-applications"

wget "ftp://invisible-island.net/xterm/xterm-$VERSION.tgz"
rm -rf xterm-$VERSION && tar -zxf "xterm-$VERSION.tgz"
rm -f "xterm-$VERSION.tgz"
cd xterm-$VERSION

./configure --prefix=$PREFIX
make && make install
