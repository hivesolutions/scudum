VERSION=${VERSION-1.15.5}

set -e

wget --no-check-certificate "http://ftp.altlinux.org/pub/people/legion/kbd/kbd-$VERSION.tar.gz"
rm -rf kbd-$VERSION && tar -zxf "kbd-$VERSION.tar.gz"
rm -f "kbd-$VERSION.tar.gz"
cd kbd-$VERSION

patch -Np1 -i kbd-$VERSION-backspace-1.patch

sed -i -e '326 s/if/while/' src/loadkeys.analyze.l

sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' man/man8/Makefile.in

./configure --prefix=/usr --datadir=/lib/kbd\
    --disable-vlock

make && make install

mv -v /usr/bin/{kbd_mode,loadkeys,openvt,setfont} /bin
