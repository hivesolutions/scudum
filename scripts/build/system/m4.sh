VERSION=${VERSION-1.4.16}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/m4/m4-$VERSION.tar.bz2"
rm -rf cd m4-$VERSION && tar -jxf "m4-$VERSION.tar.bz2"
rm -f "m4-$VERSION.tar.bz2"
cd m4-$VERSION

sed -i -e '/gets is a/d' lib/stdio.in.h
./configure --prefix=/usr

make

sed -i -e '41s/ENOENT/& || errno == EINVAL/' tests/test-readlink.h
test $TEST && make check
make install
