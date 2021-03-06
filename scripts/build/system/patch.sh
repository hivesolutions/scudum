VERSION=${VERSION-2.7.5}

set -e +h

wget --no-check-certificate --content-disposition "http://ftp.gnu.org/gnu/patch/patch-$VERSION.tar.xz"
rm -rf atch-$VERSION && tar -Jxf "patch-$VERSION.tar.xz"
rm -f  "patch-$VERSION.tar.xz"
cd patch-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
