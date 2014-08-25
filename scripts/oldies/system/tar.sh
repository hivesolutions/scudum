VERSION="1.26"
tar -jxf "tar-$VERSION.tar.bz2"
cd tar-$VERSION

sed -i -e '/gets is a/d' gnu/stdio.in.h

FORCE_UNSAFE_CONFIGURE=1\
    ./configure\
    --prefix=/usr\
    --bindir=/bin\
    --libexecdir=/usr/sbin
make
test $TEST && make check
make install
make -C doc install-html docdir=/usr/share/doc/tar-$VERSION

cd ..
rm -rf tar-$VERSION
