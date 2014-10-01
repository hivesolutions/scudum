VERSION=${VERSION-3.2}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/parted/parted-$VERSION.tar.xz"
rm -rf parted-$VERSION && tar -jxf "parted-$VERSION.tar.xz"
rm -f "parted-$VERSION.tar.xz"
cd parted-$VERSION

./configure --prefix=$PREFIX
make && make install
