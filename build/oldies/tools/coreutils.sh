VERSION="8.21"

wget -q "http://ftp.gnu.org/gnu/coreutils/coreutils-$VERSION.tar.xz"
tar -Jxf "coreutils-$VERSION.tar.xz"
rm -f "coreutils-$VERSION.tar.xz"
cd coreutils-$VERSION

./configure --prefix=$PREFIX --enable-install-program=hostname
make && make install
