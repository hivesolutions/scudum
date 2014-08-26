VERSION=${VERSION-1.5}

wget "http://ftp.gnu.org/gnu/dejagnu/dejagnu-$VERSION.tar.gz"
rm -f "dejagnu-$VERSION" && tar -zxf "dejagnu-$VERSION.tar.gz"
rm -f "dejagnu-$VERSION.tar.gz"
cd dejagnu-$VERSION

./configure --prefix=$PREFIX
make && make install
