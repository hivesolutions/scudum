VERSION=${VERSION-5.0.4}

wget -q "http://tukaani.org/xz/xz-$VERSION.tar.xz"
tar -Jxf "xz-$VERSION.tar.xz"
rm -f "xz-$VERSION.tar.xz"
cd xz-$VERSION

./configure --prefix=$PREFIX
make && make install
