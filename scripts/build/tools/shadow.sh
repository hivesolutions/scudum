[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-4.2.1}
EXTENSION=${EXTENSION-tar.xz}

set -e +h

wget --content-disposition "http://ftp.osuosl.org/pub/blfs/conglomeration/shadow/shadow-$VERSION.$EXTENSION"
rm -rf shadow-$VERSION && tar -xf "shadow-$VERSION.$EXTENSION"
rm -f "shadow-$VERSION.$EXTENSION"
cd shadow-$VERSION

./configure --prefix=$PREFIX

make && make install
