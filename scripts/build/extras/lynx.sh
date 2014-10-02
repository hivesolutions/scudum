VERSION=${VERSION-2.8.7}
VERSION_L=${VERSION_L-2-8-7}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "ftp://artfiles.org/lynx.isc.org/lynx$VERSION/lynx$VERSION.tar.gz"
rm -rf lynx$VERSION_L && tar -zxf "lynx$VERSION.tar.gz"
rm -f "lynx$VERSION.tar.gz"
cd lynx$VERSION_L

./configure --prefix=$PREFIX
make && make install
