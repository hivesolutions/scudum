VERSION=${VERSION-4.2.2}

wget -q "http://ftp.gnu.org/gnu/sed/sed-$VERSION.tar.bz2"
tar -jxf "sed-$VERSION.tar.bz2"
rm -f "sed-$VERSION.tar.bz2"
cd sed-$VERSION

./configure --prefix=$PREFIX
make && make install
