VERSION=${VERSION-1.5}

set -e +h

wget "http://ftp.gnu.org/gnu/dejagnu/dejagnu-$VERSION.tar.gz"
rm -f "dejagnu-$VERSION" && tar -zxf "dejagnu-$VERSION.tar.gz"
rm -f "dejagnu-$VERSION.tar.gz"
cd dejagnu-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
