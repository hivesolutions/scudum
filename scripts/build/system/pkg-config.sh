VERSION=${VERSION-3.0.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/pkgconf/$VERSION/pkgconf-$VERSION.tar.xz"\
    "https://distfiles.ariadne.space/pkgconf/pkgconf-$VERSION.tar.xz"
rm -rf pkgconf-$VERSION && tar -Jxf "pkgconf-$VERSION.tar.xz"
rm -f "pkgconf-$VERSION.tar.xz"
cd pkgconf-$VERSION

# uses the autotools build as meson and ninja are not available
./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --disable-static\
    --docdir=/usr/share/doc/pkgconf-$VERSION

make
test $TEST && make check
make install

ln -svf pkgconf /usr/bin/pkg-config
ln -svf pkgconf.1 /usr/share/man/man1/pkg-config.1
