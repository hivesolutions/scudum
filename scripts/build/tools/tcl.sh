VERSION=${VERSION-8.6.6}

set -e +h

wget "http://downloads.sourceforge.net/tcl/tcl-core$VERSION-src.tar.gz"
rm -rf "tcl$VERSION" && tar -zxf "tcl-core$VERSION-src.tar.gz"
rm -f "tcl-core$VERSION-src.tar.gz"
cd tcl$VERSION

cd unix
./configure --prefix=$PREFIX
make && make install

chmod -v u+w $PREFIX/lib/libtcl8.6.so
make install-private-headers
ln -svf tclsh8.6 $PREFIX/bin/tclsh
