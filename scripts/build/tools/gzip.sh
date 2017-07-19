VERSION=${VERSION-1.6}

set -e +h

wget "http://ftp.gnu.org/gnu/gzip/gzip-$VERSION.tar.xz"
rm -rf gzip-$VERSION && tar -Jxf "gzip-$VERSION.tar.xz"
rm -f "gzip-$VERSION.tar.xz"
cd gzip-$VERSION

./configure --prefix=$PREFIX
make && make install
