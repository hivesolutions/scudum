VERSION=${VERSION-4.2.8p1}
VERSION_M=${VERSION_M-4.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://archive.ntp.org/ntp4/ntp-$VERSION_M/ntp-$VERSION.tar.gz"
rm -rf ntp-$VERSION && tar -zxf "ntp-$VERSION.tar.gz"
rm -f "ntp-$VERSION.tar.gz"
cd ntp-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
