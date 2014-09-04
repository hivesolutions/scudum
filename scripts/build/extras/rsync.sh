VERSION=${VERSION-3.1.1}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://samba.org/ftp/rsync/src/rsync-$VERSION.tar.gz"
rm -rf rsync-$VERSION && tar -zxf "rsync-$VERSION.tar.gz"
rm -f "rsync-$VERSION"
cd rsync-$VERSION

./configure --prefix=$PREFIX
make && make install
