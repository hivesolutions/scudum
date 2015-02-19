VERSION=${VERSION-2.5.37}

set -e +h

wget --no-check-certificate "http://downloads.sourceforge.net/flex/flex-$VERSION.tar.bz2"
rm -rf flex-$VERSION && tar -jxf "flex-$VERSION.tar.bz2"
rm -f "flex-$VERSION.tar.bz2"
cd flex-$VERSION

wget  --no-check-certificate "http://www.linuxfromscratch.org/patches/lfs/7.3/flex-$VERSION-bison-2.6.1-1.patch"
patch -Np1 -i flex-$VERSION-bison-2.6.1-1.patch

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --docdir=/usr/share/doc/flex-$VERSION

make
test $TEST && make check
make install

ln -sv libfl.a /usr/lib/libl.a
cat > /usr/bin/lex << "EOF"
#!/bin/sh

exec /usr/bin/flex -l "$@"

EOF
chmod -v 755 /usr/bin/lex
