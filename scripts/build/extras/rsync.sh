VERSION=${VERSION-3.5.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://github.com/RsyncProject/rsync/releases/download/v$VERSION/rsync-$VERSION.tar.gz"\
    "https://download.samba.org/pub/rsync/src/rsync-$VERSION.tar.gz"\
    "https://www.mirrorservice.org/sites/rsync.samba.org/src/rsync-$VERSION.tar.gz"
rm -rf rsync-$VERSION && tar -zxf "rsync-$VERSION.tar.gz"
rm -f "rsync-$VERSION.tar.gz"
cd rsync-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX\
    --disable-xxhash --disable-zstd --disable-lz4 --disable-idn
make && make install
