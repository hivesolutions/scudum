VERSION=${VERSION-1.60}

set -e +h

wget --no-check-certificate "http://prdownloads.sourceforge.net/net-tools/net-tools-$VERSION.tar.bz2"
rm -rf net-tools-$VERSION && tar -jxf "net-tools-$VERSION.tar.bz2"
rm -f "net-tools-$VERSION.tar.bz2"
cd net-tools-$VERSION

wget --no-check-certificate http://www.linuxfromscratch.org/patches/blfs/6.3/net-tools-$VERSION-gcc34-3.patch
patch -Np1 -i net-tools-$VERSION-gcc34-3.patch

yes "" | make config > /dev/null
make && make -n install && make install
