VERSION=${VERSION-1.3.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libtirpc"

wget "http://downloads.sourceforge.net/nfs/nfs-utils-$VERSION.tar.bz2"
rm -rf nfs-utils-$VERSION && tar -jxf "nfs-utils-$VERSION.tar.bz2"
rm -f "nfs-utils-$VERSION.tar.bz2"
cd nfs-utils-$VERSION

./configure\
    --prefix=$PREFIX\
    --without-tcp-wrappers\
    --disable-nfsv4\
    --disable-gss

make && make install
chmod u+w,go+r /sbin/mount.nfs
