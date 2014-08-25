VERSION="1.10"
tar -zxf "gdbm-$VERSION.tar.gz"
cd gdbm-$VERSION

./configure --prefix=/usr --enable-libgdbm-compat
make
make check
make install

cd ..
rm -rf gdbm-$VERSION
