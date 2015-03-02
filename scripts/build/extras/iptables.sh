VERSION=${VERSION-1.4.21}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

wget "http://www.netfilter.org/projects/iptables/files/iptables-$VERSION.tar.bz2"
rm -rf iptables-$VERSION && tar -jxf "iptables-$VERSION.tar.bz2"
rm -f "iptables-$VERSION.tar.bz2"
cd iptables-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX

make && make install
