VERSION=${VERSION-5.13}

set -e +h

wget "ftp://ftp.astron.com/pub/file/file-$VERSION.tar.gz"
rm -f "file-$VERSION" && tar -zxf "file-$VERSION.tar.gz"
rm -f "file-$VERSION.tar.gz"
cd file-$VERSION

./configure --prefix=$PREFIX
make && make install
