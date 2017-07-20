VERSION=${VERSION-2.6.4}

set -e +h

wget --no-check-certificate "https://github.com/westes/flex/releases/download/v$VERSION/flex-$VERSION.tar.gz"
rm -rf flex-$VERSION && tar -zxf "flex-$VERSION.tar.gz"
rm -f "flex-$VERSION.tar.gz"
cd flex-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --docdir=/usr/share/doc/flex-$VERSION

make
test $TEST && make check
make install

chmod -v 755 /usr/bin/lex
