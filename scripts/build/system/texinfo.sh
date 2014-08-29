VERSION=${VERSION-5.0}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/texinfo/texinfo-$VERSION.tar.xz"
rm -rf texinfo-$VERSION && tar -Jxf "texinfo-$VERSION.tar.xz"
rm -f "texinfo-$VERSION.tar.xz"
cd texinfo-$VERSION

./configure --prefix=/usr

make
test $TEST && make check
make install
make TEXMF=/usr/share/texmf install-tex
