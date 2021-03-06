VERSION=${VERSION-5.2.4}

set -e +h

wget --content-disposition "http://tukaani.org/xz/xz-$VERSION.tar.xz" "--output-document=xz-$VERSION.tar.xz"
rm -rf xz-$VERSION && tar -Jxf "xz-$VERSION.tar.xz"
rm -f "xz-$VERSION.tar.xz"
cd xz-$VERSION

./configure --prefix=$PREFIX
make && make install
