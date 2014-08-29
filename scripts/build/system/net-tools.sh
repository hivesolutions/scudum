VERSION=${VERSION-CVS_20101030}

set -e +h

wget --no-check-certificate "http://anduin.linuxfromscratch.org/sources/BLFS/svn/n/net-tools-$VERSION.tar.gz"
rm -rf net-tools-$VERSION && tar -jxf "net-tools-$VERSION.tar.gz"
rm -f "net-tools-$VERSION.tar.gz"
cd net-tools-$VERSION

yes "" | make config > /dev/null
make && make install
