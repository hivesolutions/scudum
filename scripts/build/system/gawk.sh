VERSION=${VERSION-4.1.1}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/gawk/gawk-$VERSION.tar.xz"
rm -rf gawk-$VERSION && tar -Jxf "gawk-$VERSION.tar.xz"
rm -f "gawk-$VERSION.tar.xz"
cd gawk-$VERSION

./configure --prefix=/usr --libexecdir=/usr/lib

make
test $TEST && make check
make install
