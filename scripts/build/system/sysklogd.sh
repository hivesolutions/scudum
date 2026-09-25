VERSION=${VERSION-2.7.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/sysklogd/$VERSION/sysklogd-$VERSION.tar.gz"\
    "https://github.com/troglobit/sysklogd/releases/download/v$VERSION/sysklogd-$VERSION.tar.gz"
rm -rf sysklogd-$VERSION && tar -zxf "sysklogd-$VERSION.tar.gz"
rm -f "sysklogd-$VERSION.tar.gz"
cd sysklogd-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --sysconfdir=/etc\
    --runstatedir=/run\
    --without-logger\
    --disable-static\
    --docdir=/usr/share/doc/sysklogd-$VERSION

make
make install

cat > /etc/syslog.conf << "EOF"
auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# do not open any internet ports
secure_mode 2

EOF
