VERSION=${VERSION-1.5}

set -e +h

wget --no-check-certificate "http://www.infodrom.org/projects/sysklogd/download/sysklogd-$VERSION.tar.gz"
rm -rf sysklogd-$VERSION && tar -zxf "sysklogd-$VERSION.tar.gz"
rm -f "sysklogd-$VERSION.tar.gz"
cd sysklogd-$VERSION

make
make BINDIR=/sbin install

cat > /etc/syslog.conf << "EOF"
auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

EOF
