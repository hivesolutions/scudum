VERSION=${VERSION-30}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://downloads.sourceforge.net/infozip/zip$VERSION.tar.gz"\
    "http://fossies.org/linux/misc/zip$VERSION.tar.gz"
rm -rf zip$VERSION && tar -zxf "zip$VERSION.tar.gz"
rm -f "zip$VERSION.tar.gz"
cd zip$VERSION

make -f unix/Makefile generic_gcc
make prefix=$PREFIX -f unix/Makefile install
