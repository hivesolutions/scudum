VERSION=${VERSION-4.20.2}
EXTENSION=${EXTENSION-tar.xz}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/shadow/$VERSION/shadow-$VERSION.$EXTENSION"\
    "https://github.com/shadow-maint/shadow/releases/download/$VERSION/shadow-$VERSION.$EXTENSION"
rm -rf shadow-$VERSION && tar -xf "shadow-$VERSION.$EXTENSION"
rm -f "shadow-$VERSION.$EXTENSION"
cd shadow-$VERSION

find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /' {} \;

sed -i -e 's@#ENCRYPT_METHOD SHA512@ENCRYPT_METHOD YESCRYPT@'\
    -e 's@/var/spool/mail@/var/mail@'\
    -e '/PATH=/{s@/sbin:@@;s@/bin:@@}' etc/login.defs

touch /usr/bin/passwd

./configure\
    --host=$ARCH_TARGET\
    --sysconfdir=/etc\
    --disable-static\
    --with-bcrypt\
    --with-yescrypt\
    --without-libbsd\
    --disable-logind\
    --with-group-name-max-length=32

make && make exec_prefix=/usr install
make -C man install-man

if [ "$SCUDUM_CROSS" == "0" ]; then
    pwconv
    grpconv
fi

touch /etc/sub{u,g}id
