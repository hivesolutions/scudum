VERSION=${VERSION-1.22.3}

set -e +h

unset MAKEFLAGS

wget --no-check-certificate "http://ftp.gnu.org/gnu/groff/groff-$VERSION.tar.gz"
rm -rf groff-$VERSION && tar -zxf "groff-$VERSION.tar.gz"
rm -f "groff-$VERSION.tar.gz"
cd groff-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    PAGE=letter CC=gcc CXX=g++ AR=ar RANLIB=ranlib CFLAGS="" CXXFLAGS="" LDFLAGS="" ./configure --prefix=/tools
    make && make install
    make clean
fi

PAGE=letter ./configure --host=$ARCH_TARGET --prefix=/usr

if [ "$SCUDUM_CROSS" == "1" ]; then
    make GROFF_BIN_PATH=/tools/bin GROFFBIN=groff
else
    make
fi

mkdir -pv /usr/share/doc/groff-$VERSION/pdf
make install

ln -svf eqn /usr/bin/geqn
ln -svf tbl /usr/bin/gtbl
