VERSION="2.5.37"
tar -jxf "flex-$VERSION.tar.bz2"
cd flex-$VERSION

patch -Np1 -i ../flex-$VERSION-bison-2.6.1-1.patch

./configure\
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

cd ..
rm -rf flex-$VERSION
