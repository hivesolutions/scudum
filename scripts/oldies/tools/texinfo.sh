VERSION="5.0"

wget -q "http://ftp.gnu.org/gnu/texinfo/texinfo-$VERSION.tar.xz"
tar -Jxf "texinfo-$VERSION.tar.xz"
rm -f "texinfo-$VERSION.tar.xz"
cd texinfo-$VERSION

./configure --prefix=$PREFIX
make && make install
