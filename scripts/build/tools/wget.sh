VERSION=${VERSION-1.14}

wget -q "http://ftp.gnu.org/gnu/wget/wget-$VERSION.tar.gz"
tar -Jxf "wget-$VERSION.tar.xz"
rm -f "wget-$VERSION.tar.xz"
cd wget-$VERSION

./configure --prefix=$PREFIX
make && make install
