VERSION=${VERSION-4.2.1}

set -e +h

wget --content-disposition "http://ftp.gnu.org/gnu/make/make-$VERSION.tar.bz2"
rm -rf make-$VERSION && tar -jxf "make-$VERSION.tar.bz2"
rm -f "make-$VERSION.tar.bz2"
cd make-$VERSION

sed -i 's/!defined __GNU_LIBRARY__/defined __GNU_LIBRARY__/g' glob/glob.c

./configure --prefix=$PREFIX --without-guile
make && make install
