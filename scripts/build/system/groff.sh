VERSION=${VERSION-1.22.2}

set -e +h

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

ln -sv eqn /usr/bin/geqn
ln -sv tbl /usr/bin/gtbl

if [ "$SCUDUM_CROSS" == "1" ]; then
    sed -i 's/\/tools\/bin/\/usr\/bin/' /usr/bin/afmtodit
fi
