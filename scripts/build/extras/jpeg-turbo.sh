VERSION=${VERSION-1.4.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "nasm" "yasm"

rget "http://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-$VERSION.tar.gz"\
    "http://ftp.cc.uoc.gr/mirrors/linux/lfs/LFS/conglomeration/libjpeg-turbo/libjpeg-turbo-$VERSION.tar.gz"
rm -rf libjpeg-turbo-$VERSION && tar -zxf "libjpeg-turbo-$VERSION.tar.gz"
rm -f "libjpeg-turbo-$VERSION.tar.gz"
cd libjpeg-turbo-$VERSION

./configure\
    --prefix=$PREFIX\
    --mandir=$PREFIX/share/man\
    --with-jpeg8\
    --disable-static

make && make install
