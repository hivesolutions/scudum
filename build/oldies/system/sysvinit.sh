VERSION="2.88dsf"
tar -jxf "sysvinit-$VERSION.tar.bz2"
cd sysvinit-$VERSION

sed -i 's@Sending processes@& configured via /etc/inittab@g' src/init.c

sed -i -e '/utmpdump/d'\
    -e '/mountpoint/d' src/Makefile

make -C src
make -C src install

cd ..
rm -rf sysvinit-$VERSION
