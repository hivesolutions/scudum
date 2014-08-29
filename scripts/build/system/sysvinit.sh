VERSION=${VERSION-2.88dsf}

set -e +h

wget --no-check-certificate "http://download.savannah.gnu.org/releases/sysvinit/sysvinit-$VERSION.tar.bz2"
rm -rf sysvinit-$VERSION && tar -jxf "sysvinit-$VERSION.tar.bz2"
rm -f "sysvinit-$VERSION.tar.bz2"
cd sysvinit-$VERSION

sed -i 's@Sending processes@& configured via /etc/inittab@g' src/init.c

sed -i -e '/utmpdump/d'\
    -e '/mountpoint/d' src/Makefile

make -C src
make -C src install
