VERSION=${VERSION-4.4}

set -e +h

wget "http://ftp.gnu.org/gnu/sed/sed-$VERSION.tar.xz"
rm -rf "sed-$VERSION" && tar -Jxf "sed-$VERSION.tar.xz"
rm -f "sed-$VERSION.tar.xz"
cd sed-$VERSION

./configure --prefix=$PREFIX
make && make install
