VERSION=${VERSION-3.9.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "popt"

wget "https://ftp.osuosl.org/pub/blfs/conglomeration/logrotate/logrotate-$VERSION.tar.gz"
rm -rf logrotate-$VERSION && tar -zxf "logrotate-$VERSION.tar.gz"
rm -f "logrotate-$VERSION.tar.gz"
cd logrotate-$VERSION

./autogen.sh && ./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
