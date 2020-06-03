VERSION=${VERSION-1.3.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libtirpc" "libevent" "libnfsidmap" "lvm2"

wget "http://netcologne.dl.sourceforge.net/project/nfs/nfs-utils-$VERSION.tar.bz2"
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
