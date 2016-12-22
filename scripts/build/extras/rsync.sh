VERSION=${VERSION-3.1.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://samba.org/ftp/rsync/src/rsync-$VERSION.tar.gz"\
    "http://ftp.ntua.gr/mirror/rsync/rsync-$VERSION.tar.gz"
rm -rf rsync-$VERSION && tar -zxf "rsync-$VERSION.tar.gz"
rm -f "rsync-$VERSION.tar.gz"
cd rsync-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
