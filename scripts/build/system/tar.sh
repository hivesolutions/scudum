VERSION=${VERSION-1.35}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/tar/$VERSION/tar-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/tar/tar-$VERSION.tar.xz"
rgeti "https://mirrors.hive.pt/mirrors/scudum/tar/$VERSION/tar-$VERSION-acl_fix-1.patch"\
    "https://www.linuxfromscratch.org/patches/lfs/13.1/tar-$VERSION-acl_fix-1.patch"
rm -rf tar-$VERSION && tar -Jxf "tar-$VERSION.tar.xz"
rm -f "tar-$VERSION.tar.xz"
cd tar-$VERSION

patch -Np1 -i ../tar-$VERSION-acl_fix-1.patch

FORCE_UNSAFE_CONFIGURE=1\
    ./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr

make
test $TEST && make check
make install
make -C doc install-html docdir=/usr/share/doc/tar-$VERSION
