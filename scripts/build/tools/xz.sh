VERSION=${VERSION-5.0.4}

set -e

wget "http://tukaani.org/xz/xz-$VERSION.tar.xz"
rm -f "xz-$VERSION" && tar -Jxf "xz-$VERSION.tar.xz"
rm -f "xz-$VERSION.tar.xz"
cd xz-$VERSION

./configure --prefix=$PREFIX
make && make install
