[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-2.7}

set -e +h

wget "http://ftp.gnu.org/gnu/bison/bison-$VERSION.tar.xz"
rm -rf bison-$VERSION && tar -Jxf "bison-$VERSION.tar.xz"
rm -f "bison-$VERSION.tar.xz"
cd bison-$VERSION

./configure --prefix=$PREFIX

echo '#define YYENABLE_NLS 1' >> lib/config.h

make && make install
