VERSION=${VERSION-5.37}

set -e +h

wget "https://fossies.org/linux/misc/file-$VERSION.tar.gz"
rm -rf file-$VERSION && tar -zxf "file-$VERSION.tar.gz"
rm -f "file-$VERSION.tar.gz"
cd file-$VERSION

./configure --prefix=$PREFIX
make && make install
