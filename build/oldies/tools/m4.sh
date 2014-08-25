VERSION="1.4.16"

wget -q "http://ftp.gnu.org/gnu/m4/m4-$VERSION.tar.bz2"
tar -jxf "m4-$VERSION.tar.bz2"
rm -f "m4-$VERSION.tar.bz2"
cd m4-$VERSION

sed -i -e '/gets is a/d' lib/stdio.in.h
./configure --prefix=$PREFIX
make && make install
