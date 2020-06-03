VERSION=${VERSION-1.0.6}

set -e +h

wget --content-disposition "http://downloads.sourceforge.net/bzip2/bzip2-$VERSION.tar.gz?use_mirror=netcologne"
rm -rf bzip2-$VERSION && tar -zxf "bzip2-$VERSION.tar.gz"
rm -f "bzip2-$VERSION.tar.gz"
cd bzip2-$VERSION

make && make PREFIX=$PREFIX install
