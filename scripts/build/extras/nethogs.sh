VERSION=${VERSION-0.8.0}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "http://prdownloads.sourceforge.net/nethogs/nethogs-$VERSION.tar.gz"
rm -rf nethogs && tar -zxf "nethogs-$VERSION.tar.gz"
rm -f "nethogs-$VERSION.tar.gz"
cd nethogs

make && make DEST_DIR=$PREFIX install
