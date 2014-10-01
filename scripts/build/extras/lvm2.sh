VERSION=${VERSION-2.02.98}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "ftp://sources.redhat.com/pub/lvm2/LVM2.$VERSION.tgz"
rm -rf LVM2.$VERSION && tar -zxf "LVM2.$VERSION.tgz"
rm -f "LVM2.$VERSION.tgz"
cd LVM2.$VERSION

./configure --prefix=$PREFIX
make && make install
