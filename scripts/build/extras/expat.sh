VERSION=${VERSION-2.8.5}
VERSION_L=${VERSION_L-2_8_5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://mirrors.hive.pt/mirrors/scudum/expat/$VERSION/expat-$VERSION.tar.bz2"\
    "https://github.com/libexpat/libexpat/releases/download/R_$VERSION_L/expat-$VERSION.tar.bz2"\
    "https://downloads.sourceforge.net/project/expat/expat/$VERSION/expat-$VERSION.tar.bz2"\
    "--output-document=expat-$VERSION.tar.bz2"
rm -rf expat-$VERSION && tar -jxf "expat-$VERSION.tar.bz2"
rm -f "expat-$VERSION.tar.bz2"
cd expat-$VERSION

./configure --host=$ARCH_TARGET  --prefix=$PREFIX --disable-static
make && make install
