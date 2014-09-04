VERSION=${VERSION-4.1.11}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

rm -rf samba-$VERSION && git clone -b samba-$VERSION --depth 1 git://git.samba.org/samba.git samba-$VERSION
cd samba-$VERSION

./configure --prefix=$PREFIX
make && make install
