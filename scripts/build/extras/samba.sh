VERSION=${VERSION-4.1.11}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://ftp.samba.org/pub/samba/stable/samba-$VERSION.tar.gz"
rm -rf samba-$VERSION && tar -zxf "samba-$VERSION.tar.gz"
rm -f "samba-$VERSION.tar.gz"
cd samba-$VERSION

./configure --prefix=$PREFIX --without-quotas
make && make install
