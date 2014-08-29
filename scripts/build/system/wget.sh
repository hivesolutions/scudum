VERSION=${VERSION-1.15}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/wget/wget-$VERSION.tar.gz"
rm -rf wget-$VERSION && tar -zxf "wget-$VERSION.tar.gz"
rm -f "wget-$VERSION.tar.gz"
cd wget-$VERSION

./configure --prefix=/usr --with-ssl=openssl

make && make install
