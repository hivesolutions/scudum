VERSION="3.8.0"
tar -Jxf "iproute2-$VERSION.tar.xz"
cd iproute2-$VERSION

sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile

sed -i 's/-Werror//' Makefile

make DESTDIR=
make DESTDIR=\
    MANDIR=/usr/share/man\
    DOCDIR=/usr/share/doc/iproute2-3.8.0 install

cd ..
rm -rf iproute2-$VERSION
