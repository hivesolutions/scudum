VERSION=${VERSION-6.4}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "http://ftp.samba.org/pub/linux-cifs/cifs-utils/cifs-utils-$VERSION.tar.bz2"
rm -rf cifs-utils-$VERSION && tar -jxf "cifs-utils-$VERSION.tar.bz2"
rm -f "cifs-utils-$VERSION.tar.bz2"
cd cifs-utils-$VERSION

./configure --prefix=$PREFIX
make && make install
