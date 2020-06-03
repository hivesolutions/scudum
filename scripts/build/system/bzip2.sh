VERSION=${VERSION-1.0.6}

set -e +h

wget --no-check-certificate "http://netcologne.dl.sourceforge.net/project/bzip2/bzip2-$VERSION.tar.gz"
rm -rf bzip2-$VERSION && tar -zxf "bzip2-$VERSION.tar.gz"
rm -f "bzip2-$VERSION.tar.gz"
cd bzip2-$VERSION

wget --no-check-certificate "http://archive.hive.pt/files/lfs/patches/bzip2-$VERSION-install_docs-1.patch"
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

cp -v bzip2-shared /bin/bzip2
cp -av libbz2.so* /lib
ln -svf ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
rm -v /usr/bin/{bunzip2,bzcat,bzip2}
ln -svf bzip2 /bin/bunzip2
ln -svf bzip2 /bin/bzcat
