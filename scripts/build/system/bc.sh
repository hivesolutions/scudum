VERSION=${VERSION-1.06}

set -e +h

wget --no-check-certificate --content-disposition "http://ftp.gnu.org/gnu/bc/bc-$VERSION.tar.gz"
rm -rf bc-$VERSION && tar -zxf "bc-$VERSION.tar.gz"
rm -f "bc-$VERSION.tar.gz"
cd bc-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make && make install
