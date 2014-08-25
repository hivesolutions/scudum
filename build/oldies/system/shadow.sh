VERSION="4.1.5.1"
tar -jxf "shadow-$VERSION.tar.bz2"
cd shadow-$VERSION

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
    -e 's@/var/spool/mail@/var/mail@' etc/login.defs

./configure --sysconfdir=/etc
make && make install

mv -v /usr/bin/passwd /bin

pwconv
grpconv

cd ..
rm -rf shadow-$VERSION
