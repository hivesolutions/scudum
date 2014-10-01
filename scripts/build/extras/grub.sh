VERSION=${VERSION-2.00}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/grub/grub-$VERSION/gcc-$VERSION.tar.gz"
rm -rf gcc-$VERSION && tar -zxf "gcc-$VERSION.tar.gz"
rm -f "gcc-$VERSION.tar.gz"
cd gcc-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
