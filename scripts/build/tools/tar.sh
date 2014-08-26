VERSION=${VERSION-1.26}

wget "http://ftp.gnu.org/gnu/tar/tar-$VERSION.tar.bz2"
rm -f "tar-$VERSION" && tar -jxf "tar-$VERSION.tar.bz2"
rm -f "tar-$VERSION.tar.bz2"
cd tar-$VERSION

sed -i -e '/gets is a/d' gnu/stdio.in.h

./configure --prefix=$PREFIX
make && make install
