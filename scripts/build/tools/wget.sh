VERSION=${VERSION-1.15}

wget "http://ftp.gnu.org/gnu/wget/wget-$VERSION.tar.gz"
rm -rf "wget-$VERSION" && tar -zxf "wget-$VERSION.tar.gz"
rm -f "wget-$VERSION.tar.gz"
cd wget-$VERSION

./configure --prefix=$PREFIX --with-ssl=openssl --with-libssl-prefix=$PREFIX
make && make install
