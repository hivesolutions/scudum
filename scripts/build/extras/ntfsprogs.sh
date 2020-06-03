VERSION=${VERSION-2.0.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://archive.hive.pt/files/lfs/ntfsprogs-$VERSION.tar.gz"\
    "http://downloads.sourceforge.net/linux-ntfs/ntfsprogs-$VERSION.tar.gz?use_mirror=netcologne"
rm -rf ntfsprogs-$VERSION && tar -zxf "ntfsprogs-$VERSION.tar.gz"
rm -f "ntfsprogs-$VERSION.tar.gz"
cd ntfsprogs-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
