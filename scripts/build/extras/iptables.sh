VERSION=${VERSION-1.8.13}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://mirrors.hive.pt/mirrors/scudum/iptables/$VERSION/iptables-$VERSION.tar.xz"\
    "https://www.netfilter.org/projects/iptables/files/iptables-$VERSION.tar.xz"\
    "https://ftp.netfilter.org/pub/iptables/iptables-$VERSION.tar.xz"
rm -rf iptables-$VERSION && tar -Jxf "iptables-$VERSION.tar.xz"
rm -f "iptables-$VERSION.tar.xz"
cd iptables-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX\
    --disable-nftables\
    --disable-libnfnetlink\
    --disable-connlabel

make && make install
