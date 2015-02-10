VERSION=${VERSION-0.15.1b}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "ftp://ftp.be.netbsd.org/pub/pkgsrc/distfiles/libmad-$VERSION.tar.gz"\
    "http://downloads.sourceforge.net/mad/libmad-$VERSION.tar.gz"
rm -rf libmad-$VERSION && tar -zxf "libmad-$VERSION.tar.gz"
rm -f "libmad-$VERSION.tar.gz"
cd libmad-$VERSION

wget "http://www.linuxfromscratch.org/patches/blfs/svn/libmad-$VERSION-fixes-1.patch"
patch -Np1 -i libmad-$VERSION-fixes-1.patch

./configure --prefix=$PREFIX --disable-static
make && make install
