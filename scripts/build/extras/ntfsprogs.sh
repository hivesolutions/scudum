VERSION=${VERSION-2.0.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "ftp://ftp.mirrorservice.org/sites/distfiles.macports.org/ntfsprogs/ntfsprogs-$VERSION.tar.gz"\
    "http://downloads.sourceforge.net/linux-ntfs/ntfsprogs-$VERSION.tar.gz"
rm -rf ntfsprogs-$VERSION && tar -zxf "ntfsprogs-$VERSION.tar.gz"
rm -f "ntfsprogs-$VERSION.tar.gz"
cd ntfsprogs-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
