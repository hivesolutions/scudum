VERSION=${VERSION-2.8.7}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "ftp://artfiles.org/lynx.isc.org/lynx$VERSION/lynx$VERSION.tar.gz"
rm -rf lynx$VERSION && tar -zxf "lynx$VERSION.tar.gz"
rm -f "lynx$VERSION.tar.gz"
cd lynx$VERSION.tar.gz

./configure --prefix=$PREFIX
make && make install
