VERSION=${VERSION-9.10.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://ftp.isc.org/isc/bind9/$VERSION/bind-$VERSION.tar.gz"
rm -rf bind-$VERSION && tar -zxf "bind-$VERSION.tar.gz"
rm -f "bind-$VERSION.tar.gz"
cd bind-$VERSION

./configure --prefix=$PREFIX
make && make install