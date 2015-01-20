VERSION=${VERSION-5.2.0}

set -e +h

wget "http://tukaani.org/xz/xz-$VERSION.tar.xz"
rm -f "xz-$VERSION" && tar -Jxf "xz-$VERSION.tar.xz"
rm -f "xz-$VERSION.tar.xz"
cd xz-$VERSION

./configure --prefix=$PREFIX
make && make install
