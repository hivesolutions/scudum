VERSION=${VERSION-1.24.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

unset MAKEFLAGS

rgeti "https://mirrors.hive.pt/mirrors/scudum/groff/$VERSION/groff-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/groff/groff-$VERSION.tar.gz"
rm -rf groff-$VERSION && tar -zxf "groff-$VERSION.tar.gz"
rm -f "groff-$VERSION.tar.gz"
cd groff-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    PAGE=letter CC="$HOSTCC" CXX="$CXX_FOR_BUILD" AR=ar RANLIB=ranlib\
        CFLAGS="" CXXFLAGS="" LDFLAGS="" ./configure --prefix=/tools/usr
    make && make install
    make clean

    sed -i 's|GROFF_COMMAND=test-groff|GROFF_COMMAND=$(abs_top_builddir)/test-groff|' Makefile.in
    sed -i -e 's|^GROFF_BIN_PATH=$builddir|GROFF_BIN_PATH=/tools/bin|'\
        -e 's|^exec $builddir/groff|exec /tools/bin/groff|' test-groff.in
fi

PAGE=letter ./configure --host=$ARCH_TARGET --prefix=/usr

if [ "$SCUDUM_CROSS" == "1" ]; then
    make GROFF_BIN_PATH=/tools/bin GROFFBIN=groff
else
    make
fi
make install

ln -svf eqn /usr/bin/geqn
ln -svf tbl /usr/bin/gtbl
