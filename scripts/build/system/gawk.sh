VERSION=${VERSION-5.4.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/gawk/$VERSION/gawk-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/gawk/gawk-$VERSION.tar.xz"
rm -rf gawk-$VERSION && tar -Jxf "gawk-$VERSION.tar.xz"
rm -f "gawk-$VERSION.tar.xz"
cd gawk-$VERSION

sed -i 's/extras//' Makefile.in

./configure --host=$ARCH_TARGET --prefix=/usr

make
test $TEST && make check
rm -f /usr/bin/gawk-$VERSION
make install

ln -svf gawk.1 /usr/share/man/man1/awk.1
install -vDm644 doc/{awkforai.txt,*.{eps,pdf,jpg}} -t /usr/share/doc/gawk-$VERSION
