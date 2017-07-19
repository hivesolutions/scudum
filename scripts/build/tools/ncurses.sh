VERSION=${VERSION-6.0}

set -e +h

wget "ftp://ftp.gnu.org/gnu/ncurses/ncurses-$VERSION.tar.gz"
rm -rf ncurses-$VERSION && tar -zxf "ncurses-$VERSION.tar.gz"
rm -f "ncurses-$VERSION.tar.gz"
cd ncurses-$VERSION

wget "http://archive.hive.pt/files/lfs/patches/ncurses-$VERSION-gcc_5-1.patch"
patch -Np1 -i ncurses-$VERSION-gcc_5-1.patch

./configure\
    --prefix=$PREFIX\
    --with-shared\
    --without-debug\
    --without-ada\
    --enable-widec\
    --enable-overwrite

make && make install
