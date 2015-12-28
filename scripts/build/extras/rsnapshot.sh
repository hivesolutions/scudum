VERSION=${VERSION-1.4.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "rsync"

wget "http://rsnapshot.org/downloads/rsnapshot-$VERSION.tar.gz"
rm -rf rsnapshot-$VERSION && tar -zxf "rsnapshot-$VERSION.tar.gz"
rm -f "rsnapshot-$VERSION.tar.gz"
cd rsnapshot-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
