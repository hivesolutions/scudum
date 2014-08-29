VERSION=${VERSION-2.2.6}

set -e +h

wget --no-check-certificate "http://www.nano-editor.org/dist/v2.2/nano-$VERSION.tar.gz"
rm -rf nano-$VERSION && tar -zxf "nano-$VERSION.tar.gz"
rm -f "nano-$VERSION.tar.gz"
cd nano-$VERSION

./configure --prefix=/usr

make && make install
