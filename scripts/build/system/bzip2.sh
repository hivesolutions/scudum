VERSION=${VERSION-1.0.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/bzip2/$VERSION/bzip2-$VERSION.tar.gz"\
    "https://www.sourceware.org/pub/bzip2/bzip2-$VERSION.tar.gz"
rm -rf bzip2-$VERSION && tar -zxf "bzip2-$VERSION.tar.gz"
rm -f "bzip2-$VERSION.tar.gz"
cd bzip2-$VERSION

rgeti "https://mirrors.hive.pt/mirrors/scudum/bzip2/$VERSION/bzip2-$VERSION-install_docs-1.patch"\
    "https://www.linuxfromscratch.org/patches/lfs/13.1/bzip2-$VERSION-install_docs-1.patch"
patch -Np1 -i bzip2-$VERSION-install_docs-1.patch

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

if [ "$SCUDUM_CROSS" == "1" ]; then
    make -f Makefile-libbz2_so CC="$CC"
    make clean

    make CC="$CC" libbz2.a bzip2 bzip2recover
    test $TEST && make CC="$CC" test
    make PREFIX=/usr install
else
    make -f Makefile-libbz2_so
    make clean

    make libbz2.a bzip2 bzip2recover
    test $TEST && make test
    make PREFIX=/usr install
fi

cp -av libbz2.so.* /usr/lib
ln -svf libbz2.so.$VERSION /usr/lib/libbz2.so
ln -svf libbz2.so.$VERSION /usr/lib/libbz2.so.1

cp -v bzip2-shared /usr/bin/bzip2
ln -svf bzip2 /usr/bin/bunzip2
ln -svf bzip2 /usr/bin/bzcat

rm -fv /usr/lib/libbz2.a
