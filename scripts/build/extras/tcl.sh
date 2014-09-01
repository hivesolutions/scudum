VERSION=${VERSION-8.6.0}

set -e +h

wget "http://prdownloads.sourceforge.net/tcl/tcl$VERSION-src.tar.gz"
rm -f "tcl$VERSION" && tar -zxf "tcl$VERSION-src.tar.gz"
rm -f "tcl$VERSION-src.tar.gz"
cd tcl$VERSION

cd unix
./configure --prefix=$PREFIX
make && make install
