VERSION=${VERSION-8.6.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://netcologne.dl.sourceforge.net/project/tcl/tcl$VERSION-src.tar.gz"
rm -rf tcl$VERSION && tar -zxf "tcl$VERSION-src.tar.gz"
rm -f "tcl$VERSION-src.tar.gz"
cd tcl$VERSION

cd unix
./configure --prefix=$PREFIX
make && make install
