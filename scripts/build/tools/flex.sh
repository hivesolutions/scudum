[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-2.6.4}

set -e +h

wget "https://github.com/westes/flex/releases/download/v$VERSION/flex-$VERSION.tar.gz"
rm -rf flex-$VERSION && tar -zxf "flex-$VERSION.tar.gz"
rm -f "flex-$VERSION.tar.gz"
cd flex-$VERSION

./configure --prefix=$PREFIX

make && make install
