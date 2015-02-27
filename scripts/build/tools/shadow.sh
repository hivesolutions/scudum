[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-4.2.1}
EXTENSION=${EXTENSION-tar.xz}

set -e +h

wget "http://pkg-shadow.alioth.debian.org/releases/shadow-$VERSION.$EXTENSION"
rm -rf shadow-$VERSION && tar -xf "shadow-$VERSION.$EXTENSION"
rm -f "shadow-$VERSION.$EXTENSION"
cd shadow-$VERSION

./configure --prefix=$PREFIX

make && make install
