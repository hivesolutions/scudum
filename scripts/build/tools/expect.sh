VERSION=${VERSION-5.45}

wget -q "http://prdownloads.sourceforge.net/expect/expect$VERSION.tar.gz"
tar -zxf "expect$VERSION.tar.gz"
rm -f "expect$VERSION.tar.gz"
cd expect$VERSION

cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure --prefix=$PREFIX --with-tcl=$PREFIX/lib\
    --with-tclinclude=$PREFIX/include

make
make SCRIPTS="" install
