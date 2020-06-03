VERSION=${VERSION-0.15.1b}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://downloads.sourceforge.net/mad/libmad-$VERSION.tar.gz?use_mirror=ayera"\
    "ftp://ftp.be.netbsd.org/pub/pkgsrc/distfiles/libmad-$VERSION.tar.gz"
rm -rf libmad-$VERSION && tar -zxf "libmad-$VERSION.tar.gz"
rm -f "libmad-$VERSION.tar.gz"
cd libmad-$VERSION

wget --content-disposition "http://archive.hive.pt/files/lfs/patches/libmad-$VERSION-fixes-1.patch"
patch -Np1 -i libmad-$VERSION-fixes-1.patch

./configure --prefix=$PREFIX --disable-static
make && make install
