VERSION=${VERSION-2.7.1}

wget -q "http://ftp.gnu.org/gnu/nettle/nettle-$VERSION.tar.gz"
tar -zxf "nettle-$VERSION.tar.gz"
rm -f "nettle-$VERSION.tar.gz"
cd nettle-$VERSION

./configure --prefix=$PREFIX
make && make install
