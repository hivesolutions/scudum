VERSION=${VERSION-8.6.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://downloads.sourceforge.net/tcl/tcl$VERSION-src.tar.gz?use_mirror=netix"
rm -rf tcl$VERSION && tar -zxf "tcl$VERSION-src.tar.gz"
rm -f "tcl$VERSION-src.tar.gz"
cd tcl$VERSION

cd unix
./configure --prefix=$PREFIX
make && make install
