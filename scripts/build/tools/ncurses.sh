VERSION=${VERSION-6.0}

set -e +h

wget --content-disposition "ftp://ftp.gnu.org/gnu/ncurses/ncurses-$VERSION.tar.gz"
rm -rf ncurses-$VERSION && tar -zxf "ncurses-$VERSION.tar.gz"
rm -f "ncurses-$VERSION.tar.gz"
cd ncurses-$VERSION

CPPFLAGS="-P" ./configure\
    --prefix=$PREFIX\
    --with-shared\
    --without-debug\
    --without-ada\
    --enable-widec\
    --enable-overwrite

make && make install
