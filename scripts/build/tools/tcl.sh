VERSION=${VERSION-8.6.3}

set -e +h

wget "http://downloads.sourceforge.net/tcl/tcl$VERSION-src.tar.gz"
rm -f "tcl$VERSION" && tar -zxf "tcl$VERSION-src.tar.gz"
rm -f "tcl$VERSION-src.tar.gz"
cd tcl$VERSION

cd unix
./configure --prefix=$PREFIX
make && make install

chmod -v u+w $PREFIX/lib/libtcl8.6.so
make install-private-headers
ln -sv tclsh8.6 $PREFIX/bin/tclsh
