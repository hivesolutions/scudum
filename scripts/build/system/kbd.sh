VERSION=${VERSION-2.2.0}

set -e +h

wget --no-check-certificate --content-disposition "http://ftp.altlinux.org/pub/people/legion/kbd/kbd-$VERSION.tar.xz"
rm -rf kbd-$VERSION && tar -Jxf "kbd-$VERSION.tar.xz"
rm -f "kbd-$VERSION.tar.xz"
cd kbd-$VERSION

wget --no-check-certificate --content-disposition "http://archive.hive.pt/files/lfs/patches/kbd-$VERSION-backspace-1.patch"
patch -Np1 -i kbd-$VERSION-backspace-1.patch

sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

./configure --host=$ARCH_TARGET --prefix=/usr --datadir=/lib/kbd\
    --disable-vlock

make M4=/tools/bin/m4 && make install

mv -v /usr/bin/{kbd_mode,loadkeys,openvt,setfont} /bin
