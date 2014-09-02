VERSION=${VERSION-2.0.0}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/linux-ntfs/ntfsprogs-$VERSION.tar.gz"
rm -rf ntfsprogs-$VERSION && tar -zxf "ntfsprogs-$VERSION.tar.gz"
rm -f "ntfsprogs-$VERSION.tar.gz"
cd ntfsprogs-$VERSION

./configure --prefix=$PREFIX
make && make install
