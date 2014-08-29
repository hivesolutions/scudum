VERSION=${VERSION-2.30}

set -e +h

wget --no-check-certificate "http://anduin.linuxfromscratch.org/sources/LFS/lfs-packages/conglomeration/iana-etc/iana-etc-$VERSION.tar.bz2"
rm -rf iana-etc-$VERSION && tar -jxf "iana-etc-$VERSION.tar.bz2"
rm -f "iana-etc-$VERSION.tar.bz2"
cd iana-etc-$VERSION

make && make install
