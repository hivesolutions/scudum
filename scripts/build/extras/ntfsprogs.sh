VERSION=${VERSION-2014.2.15}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "http://tuxera.com/opensource/ntfs-3g_ntfsprogs-$VERSION.tgz"
rm -rf ntfs-3g_ntfsprogs-$VERSION && tar -zxf "ntfs-3g_ntfsprogs-$VERSION.tgz"
rm -f "ntfs-3g_ntfsprogs-$VERSION.tgz"
cd ntfs-3g_ntfsprogs-$VERSION

./configure --prefix=$PREFIX
make && make instal
