VERSION=${VERSION-2.14}

wget -q "http://ftp.gnu.org/gnu/grep/grep-$VERSION.tar.xz"
tar -Jxf "grep-$VERSION.tar.xz"
rm -f "grep-$VERSION.tar.xz"
cd grep-$VERSION

./configure --prefix=$PREFIX
make && make install
