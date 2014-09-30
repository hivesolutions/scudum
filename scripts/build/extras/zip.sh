VERSION=${VERSION-30}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/infozip/zip$VERSION.tgz"
rm -rf zip$VERSION && tar -zxf "zip$VERSION.tgz"
rm -f "zip$VERSION.tgz"
cd zip$VERSION

make -f unix/Makefile generic_gcc
make prefix=$PREFIX -f unix/Makefile install
