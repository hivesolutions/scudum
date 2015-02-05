VERSION=${VERSION-3.1.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://samba.org/ftp/rsync/src/rsync-$VERSION.tar.gz"\
    "http://ftp.heanet.ie/mirrors/samba/rsync/rsync-$VERSION.tar.gz"
rm -rf rsync-$VERSION && tar -zxf "rsync-$VERSION.tar.gz"
rm -f "rsync-$VERSION.tar.gz"
cd rsync-$VERSION

./configure --prefix=$PREFIX
make && make install
