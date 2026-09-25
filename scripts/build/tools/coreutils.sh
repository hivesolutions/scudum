VERSION=${VERSION-9.11}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/coreutils/$VERSION/coreutils-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/coreutils/coreutils-$VERSION.tar.xz"
rm -rf coreutils-$VERSION && tar -Jxf "coreutils-$VERSION.tar.xz"
rm -f "coreutils-$VERSION.tar.xz"
cd coreutils-$VERSION

./configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(build-aux/config.guess)\
    --enable-install-program=hostname

make && make DESTDIR=$SCUDUM install

mv -v $SCUDUM/usr/bin/chroot $SCUDUM/usr/sbin
mkdir -pv $SCUDUM/usr/share/man/man8
mv -v $SCUDUM/usr/share/man/man1/chroot.1 $SCUDUM/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' $SCUDUM/usr/share/man/man8/chroot.8
