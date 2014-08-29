VERSION=${VERSION-1.5}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "http://prdownloads.sourceforge.net/bridge/bridge-utils-$VERSION.tar.gz"
rm -rf bridge-utils-$VERSION && tar -zxf "bridge-utils-$VERSION.tar.gz"
rm -f "bridge-utils-$VERSION.tar.gz"
cd bridge-utils-$VERSION

autoconf -o configure configure.in
./configure --prefix=$PREFIX
make && make install
