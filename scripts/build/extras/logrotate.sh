VERSION=${VERSION-3.11.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "popt"

wget "https://ftp.osuosl.org/pub/blfs/conglomeration/logrotate/logrotate-$VERSION.tar.xz"
rm -rf logrotate-$VERSION && tar -Jxf "logrotate-$VERSION.tar.xz"
rm -f "logrotate-$VERSION.tar.xz"
cd logrotate-$VERSION

./autogen.sh && ./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
