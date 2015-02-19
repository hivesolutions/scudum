VERSION=${VERSION-0.18.2}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/gettext/gettext-$VERSION.tar.gz"
rm -rf gettext-$VERSION && tar -zxf "gettext-$VERSION.tar.gz"
rm -f "gettext-$VERSION.tar.gz"
cd gettext-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --docdir=/usr/share/doc/gettext-$VERSION

make
test $TEST && make check
make install
