VERSION=${VERSION-3.1}

set -e +h

wget "http://ftp.gnu.org/gnu/grep/grep-$VERSION.tar.xz"
rm -rf grep-$VERSION && tar -Jxf "grep-$VERSION.tar.xz"
rm -f "grep-$VERSION.tar.xz"
cd grep-$VERSION

./configure --prefix=$PREFIX
make && make install
