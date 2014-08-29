VERSION=${VERSION-1.4.16}

set -e +h

wget "http://ftp.gnu.org/gnu/m4/m4-$VERSION.tar.bz2"
rm -rf "m4-$VERSION" && tar -jxf "m4-$VERSION.tar.bz2"
rm -f "m4-$VERSION.tar.bz2"
cd m4-$VERSION

sed -i -e '/gets is a/d' lib/stdio.in.h
./configure --prefix=$PREFIX
make && make install
