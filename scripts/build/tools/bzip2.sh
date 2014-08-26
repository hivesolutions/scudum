VERSION=${VERSION-1.0.6}

set -e

wget "http://www.bzip.org/$VERSION/bzip2-$VERSION.tar.gz"
rm -f "bzip2-$VERSION" && tar -zxf "bzip2-$VERSION.tar.gz"
rm -f "bzip2-$VERSION.tar.gz"
cd bzip2-$VERSION

make
make PREFIX=$PREFIX install
