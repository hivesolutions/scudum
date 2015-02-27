[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-2.5.37}

set -e +h

wget "http://downloads.sourceforge.net/flex/flex-$VERSION.tar.bz2"
rm -rf flex-$VERSION && tar -jxf "flex-$VERSION.tar.bz2"
rm -f "flex-$VERSION.tar.bz2"
cd flex-$VERSION

wget  --no-check-certificate "http://www.linuxfromscratch.org/patches/lfs/7.3/flex-$VERSION-bison-2.6.1-1.patch"
patch -Np1 -i flex-$VERSION-bison-2.6.1-1.patch

./configure --prefix=$PREFIX

make && make install
