VERSION=${VERSION-2.6.4}

set -e +h

wget --no-check-certificate "http://downloads.sourceforge.net/flex/flex-$VERSION.tar.bz2"
rm -rf flex-$VERSION && tar -jxf "flex-$VERSION.tar.bz2"
rm -f "flex-$VERSION.tar.bz2"
cd flex-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --docdir=/usr/share/doc/flex-$VERSION

make
test $TEST && make check
make install

chmod -v 755 /usr/bin/lex
