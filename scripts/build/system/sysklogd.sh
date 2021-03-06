VERSION=${VERSION-1.5.1}

set -e +h

wget --no-check-certificate --content-disposition "http://www.infodrom.org/projects/sysklogd/download/sysklogd-$VERSION.tar.gz"
rm -rf sysklogd-$VERSION && tar -zxf "sysklogd-$VERSION.tar.gz"
rm -f "sysklogd-$VERSION.tar.gz"
cd sysklogd-$VERSION

sed -i '/Error loading kernel symbols/{n;n;d}' ksym_mod.c
sed -i 's/union wait/int/' syslogd.c

if [ "$SCUDUM_CROSS" == "1" ]; then
    make CC="$CC"
    make INSTALL="/tools/bin/install --strip-program=/cross/$ARCH_TARGET/bin/strip" BINDIR=/sbin install
else
    make
    make BINDIR=/sbin install
fi

cat > /etc/syslog.conf << "EOF"
auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

EOF
