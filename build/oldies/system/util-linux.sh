VERSION="2.22.2"
tar -Jxf "util-linux-$VERSION.tar.xz"
cd util-linux-$VERSION

sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
    $(grep -rl '/etc/adjtime' .)
mkdir -pv /var/lib/hwclock

./configure --disable-su --disable-sulogin --disable-login
make && make install

cd ..
rm -rf util-linux-$VERSION
