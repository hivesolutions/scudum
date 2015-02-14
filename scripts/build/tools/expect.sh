VERSION=${VERSION-5.45}

set -e +h

wget "http://downloads.sourceforge.net/expect/expect$VERSION.tar.gz"
rm -f "expect$VERSION" && tar -zxf "expect$VERSION.tar.gz"
rm -f "expect$VERSION.tar.gz"
cd expect$VERSION

cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

wget https://raw.githubusercontent.com/maximeh/buildroot/master/package/expect/expect-0001-enable-cross-compilation.patch
patch -Np1 -i expect-0001-enable-cross-compilation.patch

./configure --host=$ARCH_TARGET --prefix=$PREFIX --with-tcl=$PREFIX/lib\
    --with-tclinclude=$PREFIX/include
make && make SCRIPTS="" install
