VERSION="4.2.2"
tar -jxf "sed-$VERSION.tar.bz2"
cd sed-$VERSION

./configure --prefix=/usr --bindir=/bin\
    --htmldir=/usr/share/doc/sed-4.2.2
make
make html
make check
make install
make -C doc install-html

cd ..
rm -rf sed-$VERSION
