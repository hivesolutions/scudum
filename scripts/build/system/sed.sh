VERSION=${VERSION-4.2.2}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/sed/sed-$VERSION.tar.bz2"
rm -rf sed-$VERSION && tar -jxf "sed-$VERSION.tar.bz2"
rm -f "sed-$VERSION.tar.bz2"
cd sed-$VERSION

./configure --prefix=/usr --bindir=/bin\
    --htmldir=/usr/share/doc/sed-$VERSION

make
make html
test $TEST && make check
make install
make -C doc install-html
