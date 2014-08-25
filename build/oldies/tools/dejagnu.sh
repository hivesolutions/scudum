VERSION="1.5"

wget -q "http://ftp.gnu.org/gnu/dejagnu/dejagnu-$VERSION.tar.gz"
tar -zxf "dejagnu-$VERSION.tar.gz"
rm -f "dejagnu-$VERSION.tar.gz"
cd dejagnu-$VERSION

./configure --prefix=$PREFIX
make && make install
