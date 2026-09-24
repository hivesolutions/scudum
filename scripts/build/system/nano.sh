VERSION=${VERSION-9.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/nano/$VERSION/nano-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/nano/nano-$VERSION.tar.xz"
rm -rf nano-$VERSION && tar -Jxf "nano-$VERSION.tar.xz"
rm -f "nano-$VERSION.tar.xz"
cd nano-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --sysconfdir=/etc\
    --enable-utf8\
    --docdir=/usr/share/doc/nano-$VERSION

make && make install

ln -svf nano /usr/bin/pico
