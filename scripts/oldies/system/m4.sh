VERSION="1.4.16"
tar -jxf "m4-$VERSION.tar.bz2"
cd m4-$VERSION

sed -i -e '/gets is a/d' lib/stdio.in.h
./configure --prefix=/usr
make

sed -i -e '41s/ENOENT/& || errno == EINVAL/' tests/test-readlink.h
make check

make install

cd ..
rm -rf m4-$VERSION
