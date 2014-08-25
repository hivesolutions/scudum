VERSION="0.18.2"

wget -q "http://ftp.gnu.org/gnu/gettext/gettext-0.18.2.tar.gz"
tar -zxf "gettext-$VERSION.tar.gz"
rm -f "gettext-$VERSION.tar.xz"
cd gettext-$VERSION

cd gettext-tools
EMACS="no" ./configure --prefix=$PREFIX --disable-shared
make -C gnulib-lib
make -C src msgfmt
cp -v src/msgfmt $PREFIX/bin
cd ..
