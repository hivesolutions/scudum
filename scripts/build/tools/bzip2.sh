VERSION=${VERSION-1.0.8}

set -e +h

wget --content-disposition "http://sourceware.org/pub/bzip2/bzip2-$VERSION.tar.gz"
rm -rf bzip2-$VERSION && tar -zxf "bzip2-$VERSION.tar.gz"
rm -f "bzip2-$VERSION.tar.gz"
cd bzip2-$VERSION

make -f Makefile-libbz2_so && make clean

make && make PREFIX=$PREFIX install

cp -v bzip2-shared $PREFIX/bin/bzip2
cp -av libbz2.so* $PREFIX/lib
ln -svf libbz2.so.1.0 $PREFIX/lib/libbz2.so
