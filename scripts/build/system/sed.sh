VERSION=${VERSION-4.4}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/sed/sed-$VERSION.tar.xz"
rm -rf sed-$VERSION && tar -Jxf "sed-$VERSION.tar.xz"
rm -f "sed-$VERSION.tar.xz"
cd sed-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --bindir=/bin\
    --htmldir=/usr/share/doc/sed-$VERSION

make
make html
test $TEST && make check
make install
make -C doc install-html

ln -s /bin/sed /usr/bin/sed
