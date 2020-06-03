VERSION=${VERSION-1.3.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libtirpc" "libevent" "libnfsidmap" "lvm2"

wget --content-disposition "http://downloads.sourceforge.net/nfs/nfs-utils-$VERSION.tar.bz2?use_mirror=astuteinternet"
rm -rf nfs-utils-$VERSION && tar -jxf "nfs-utils-$VERSION.tar.bz2"
rm -f "nfs-utils-$VERSION.tar.bz2"
cd nfs-utils-$VERSION

./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --without-tcp-wrappers\
    --disable-gss\
    --disable-ipv6

make && make install
chmod u+w,go+r /sbin/mount.nfs
