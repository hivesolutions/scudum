VERSION="1.5"
tar -zxf "sysklogd-$VERSION.tar.gz"
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

cd ..
rm -rf sysklogd-$VERSION
