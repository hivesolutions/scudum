VERSION=${VERSION-5.9}

wget -q "ftp://ftp.gnu.org/gnu/ncurses/ncurses-$VERSION.tar.gz"
tar -zxf "ncurses-$VERSION.tar.gz"
rm -f "ncurses-$VERSION.tar.gz"
cd ncurses-$VERSION

./configure --prefix=$PREFIX --with-shared\
    --without-debug --without-ada --enable-overwrite

make && make install
