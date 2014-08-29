VERSION=${VERSION-1.4.21}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "http://www.netfilter.org/projects/iptables/files/iptables-$VERSION.tar.bz2"
rm -rf iptables-$VERSION && tar -Jxf "iptables-$VERSION.tar.bz2"
rm -f "iptables-$VERSION.tar.bz2"
cd iptables-$VERSION

./configure --prefix=$PREFIX\
    --sbindir=/sbin\
    --with-xtlibdir=/lib/xtables\
    --enable-libipq

make && make install
