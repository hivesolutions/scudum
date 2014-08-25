VERSION="1.0.6"

wget -q "http://www.bzip.org/$VERSION/bzip2-$VERSION.tar.gz"
tar -zxf "bzip2-$VERSION.tar.gz"
rm -f "bzip2-$VERSION.tar.gz"
cd bzip2-$VERSION

make
make PREFIX=$PREFIX install
