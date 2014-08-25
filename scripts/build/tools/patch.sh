VERSION=${VERSION-2.7.1}

wget -q "http://ftp.gnu.org/gnu/patch/patch-$VERSION.tar.xz"
tar -Jxf "patch-$VERSION.tar.xz"
rm -f "patch-$VERSION.tar.xz"
cd patch-$VERSION

./configure --prefix=$PREFIX
make && make install
