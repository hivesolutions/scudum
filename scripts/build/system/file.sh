VERSION=${VERSION-5.37}

set -e +h

wget --no-check-certificate --content-disposition "https://sources.buildroot.net/file/file-$VERSION.tar.gz"
rm -rf file-$VERSION && tar -zxf "file-$VERSION.tar.gz"
rm -f "file-$VERSION.tar.gz"
cd file-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
