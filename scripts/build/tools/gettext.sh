VERSION=${VERSION-0.18.2}

set -e +h

wget "http://ftp.gnu.org/gnu/gettext/gettext-$VERSION.tar.gz"
rm -rf "gettext-$VERSION" && tar -zxf "gettext-$VERSION.tar.gz"
rm -f "gettext-$VERSION.tar.xz"
cd gettext-$VERSION

cd gettext-tools
EMACS="no" ./configure --prefix=$PREFIX --disable-shared
make -C gnulib-lib
make -C src msgfmt
cp -v src/msgfmt $PREFIX/bin
cd ..
