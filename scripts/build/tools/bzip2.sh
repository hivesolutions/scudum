VERSION=${VERSION-1.0.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/bzip2/$VERSION/bzip2-$VERSION.tar.gz"\
    "https://www.sourceware.org/pub/bzip2/bzip2-$VERSION.tar.gz"
rm -rf bzip2-$VERSION && tar -zxf "bzip2-$VERSION.tar.gz"
rm -f "bzip2-$VERSION.tar.gz"
cd bzip2-$VERSION

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

make -f Makefile-libbz2_so && make clean
make && make PREFIX=/usr install

cp -av libbz2.so.* /usr/lib
ln -svf libbz2.so.$VERSION /usr/lib/libbz2.so
ln -svf libbz2.so.$VERSION /usr/lib/libbz2.so.1

cp -v bzip2-shared /usr/bin/bzip2
