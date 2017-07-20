[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-2.6.4}

set -e +h

wget "http://downloads.sourceforge.net/flex/flex-$VERSION.tar.bz2"
rm -rf flex-$VERSION && tar -jxf "flex-$VERSION.tar.bz2"
rm -f "flex-$VERSION.tar.bz2"
cd flex-$VERSION

./configure --prefix=$PREFIX

make && make install
