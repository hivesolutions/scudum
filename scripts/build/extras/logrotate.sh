VERSION=${VERSION-3.22.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "popt"

rget "https://mirrors.hive.pt/mirrors/scudum/logrotate/$VERSION/logrotate-$VERSION.tar.xz"\
    "https://github.com/logrotate/logrotate/releases/download/$VERSION/logrotate-$VERSION.tar.xz"\
    "https://ftp.osuosl.org/pub/blfs/conglomeration/logrotate/logrotate-$VERSION.tar.xz"
rm -rf logrotate-$VERSION && tar -Jxf "logrotate-$VERSION.tar.xz"
rm -f "logrotate-$VERSION.tar.xz"
cd logrotate-$VERSION

./autogen.sh && ./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
