VERSION=${VERSION-6.2}

set -e +h

wget --content-disposition "ftp://ftp.gnu.org/gnu/ncurses/ncurses-$VERSION.tar.gz"
rm -rf ncurses-$VERSION && tar -zxf "ncurses-$VERSION.tar.gz"
rm -f "ncurses-$VERSION.tar.gz"
cd ncurses-$VERSION

CPPFLAGS="-P" ./configure\
    --prefix=$PREFIX\
    --with-shared\
    --without-termlib\
    --without-debug\
    --without-ada\
    --enable-widec\
    --enable-overwrite

make && make install

ln -svf libncursesw.so.6 $PREFIX/lib/libtinfo.so.6
ln -svf libtinfo.so.6 $PREFIX/lib/libtinfo.so
