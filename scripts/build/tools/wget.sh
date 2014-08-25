VERSION=${VERSION-1.14}

wget -q "http://ftp.gnu.org/gnu/wget/wget-$VERSION.tar.gz"
tar -zxf "wget-$VERSION.tar.gz"
rm -f "wget-$VERSION.tar.gz"
cd wget-$VERSION

./configure --prefix=$PREFIX --with-ssl=openssl
make && make install
