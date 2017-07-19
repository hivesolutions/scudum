[ "$SCUDUM_CROSS" == "1" ] && exit 0 || true

VERSION=${VERSION-6.4}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/texinfo/texinfo-$VERSION.tar.xz"
rm -rf texinfo-$VERSION && tar -Jxf "texinfo-$VERSION.tar.xz"
rm -f "texinfo-$VERSION.tar.xz"
cd texinfo-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
make install
make TEXMF=/usr/share/texmf install-tex
