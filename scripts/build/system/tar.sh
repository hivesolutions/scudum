VERSION=${VERSION-1.29}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/tar/tar-$VERSION.tar.bz2"
rm -rf tar-$VERSION && tar -jxf "tar-$VERSION.tar.bz2"
rm -f "tar-$VERSION.tar.bz2"
cd tar-$VERSION

FORCE_UNSAFE_CONFIGURE=1\
    ./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --bindir=/bin\
    --libexecdir=/usr/sbin

make
test $TEST && make check
make install
make -C doc install-html docdir=/usr/share/doc/tar-$VERSION
