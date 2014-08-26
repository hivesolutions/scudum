VERSION="4.0.2"

wget "http://ftp.gnu.org/gnu/gawk/gawk-$VERSION.tar.xz"
tar -Jxf "gawk-$VERSION.tar.xz"
rm -f "gawk-$VERSION.tar.xz"
cd gawk-$VERSION

./configure --prefix=$PREFIX
make && make install
