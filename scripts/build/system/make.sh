VERSION=${VERSION-3.82}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/make/make-$VERSION.tar.bz2"
rm -rf make-$VERSION && tar -jxf "make-$VERSION.tar.bz2"
rm -f "make-$VERSION.tar.bz2"
cd make-$VERSION

wget --no-check-certificate "http://www.linuxfromscratch.org/patches/lfs/7.3/make-$VERSION-upstream_fixes-3.patch"
patch -Np1 -i make-$VERSION-upstream_fixes-3.patch

./configure --prefix=/usr

make
test $TEST && make check
make install
