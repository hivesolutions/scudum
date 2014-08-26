VERSION=${VERSION-4.1.4.3}

wget --no-check-certificate "http://pkg-shadow.alioth.debian.org/releases/shadow-$VERSION.tar.bz2"
rm -rf shadow-$VERSION && tar -jxf "shadow-$VERSION.tar.bz2"
rm -f "shadow-$VERSION.tar.bz2"
cd shadow-$VERSION

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@'\
    -e 's@/var/spool/mail@/var/mail@' etc/login.defs

./configure --sysconfdir=/etc

make && make install

mv -v /usr/bin/passwd /bin

pwconv
grpconv
