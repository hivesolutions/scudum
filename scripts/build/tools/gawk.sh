VERSION=${VERSION-4.1.1}

set -e +h

wget "http://ftp.gnu.org/gnu/gawk/gawk-$VERSION.tar.xz"
rm -rf "gawk-$VERSION" && tar -Jxf "gawk-$VERSION.tar.xz"
rm -f "gawk-$VERSION.tar.xz"
cd gawk-$VERSION

./configure --prefix=$PREFIX
make && make install
