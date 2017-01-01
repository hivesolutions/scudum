VERSION=${VERSION-60}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://downloads.sourceforge.net/infozip/unzip$VERSION.tar.gz"\
    "http://fossies.org/linux/misc/unzip$VERSION.tar.gz"
rm -rf unzip$VERSION && tar -zxf "unzip$VERSION.tar.gz"
rm -f "unzip$VERSION.tar.gz"
cd unzip$VERSION

make -f unix/Makefile generic
make prefix=$PREFIX -f unix/Makefile install
