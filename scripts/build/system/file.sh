VERSION=${VERSION-5.22}

set -e +h

wget --no-check-certificate "ftp://ftp.astron.com/pub/file/file-$VERSION.tar.gz"
rm -rf file-$VERSION && tar -zxf "file-$VERSION.tar.gz"
rm -f "file-$VERSION.tar.gz"
cd file-$VERSION

./configure --prefix=/usr

make
test $TEST && make check
make install
