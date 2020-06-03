VERSION=${VERSION-8.6.8}

set -e +h

wget --content-disposition "https://downloads.sourceforge.net/tcl/Tcl/$VERSION/tcl$VERSION-src.tar.gz?use_mirror=netcologne"
rm -rf tcl$VERSION && tar -zxf "tcl-core$VERSION-src.tar.gz"
rm -f "tcl-core$VERSION-src.tar.gz"
cd tcl$VERSION

cd unix
./configure --prefix=$PREFIX
make && make install

chmod -v u+w $PREFIX/lib/libtcl8.6.so
make install-private-headers
ln -svf tclsh8.6 $PREFIX/bin/tclsh
