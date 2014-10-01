VERSION=${VERSION-2.00}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/grub/grub-$VERSION.tar.gz"
rm -rf grub-$VERSION && tar -zxf "grub-$VERSION.tar.gz"
rm -f "grub-$VERSION.tar.gz"
cd grub-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
