VERSION=${VERSION-CVS_20101030}

set -e +h

wget --no-check-certificate "http://anduin.linuxfromscratch.org/sources/BLFS/svn/n/net-tools-$VERSION.tar.gz"
rm -rf net-tools-$VERSION && tar -zxf "net-tools-$VERSION.tar.gz"
rm -f "net-tools-$VERSION.tar.gz"
cd net-tools-$VERSION

wget --no-check-certificate http://www.linuxfromscratch.org/patches/blfs/7.5/net-tools-$VERSION-remove_dups-1.patch
patch -Np1 -i net-tools-$VERSION-remove_dups-1.patch

if [ "$SCUDUM_CROSS" == "1" ]; then
    yes "" | ./configure.sh config.in > /dev/null
    make CC="$CC" LD="$LD" && make install
else
    yes "" | make config > /dev/null
    make && make install
fi
