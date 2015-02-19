if [ "$SCUDUM-CROSS" == "1" ]; then
    VERSION=${VERSION-4.1.4.2}
    EXTENSION=${EXTENSION-tar.gz}
else
    VERSION=${VERSION-4.2.1}
    EXTENSION=${EXTENSION-tar.xz}
fi

set -e +h

wget --no-check-certificate "http://pkg-shadow.alioth.debian.org/releases/shadow-$VERSION.$EXTENSION"
rm -rf shadow-$VERSION && tar -xf "shadow-$VERSION.$EXTENSION"
rm -f "shadow-$VERSION.$EXTENSION"
cd shadow-$VERSION

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@'\
    -e 's@/var/spool/mail@/var/mail@' etc/login.defs

sed -i 's/as_fn_error ()/as_fn_error ()\n{\nreturn 0\n}\nold_as_fn_error ()\n/' configure

./configure --host=$ARCH_TARGET --sysconfdir=/etc

make && make install

mv -v /usr/bin/passwd /bin

if [ "$SCUDUM-CROSS" == "0" ];
    pwconv
    grpconv
fi
