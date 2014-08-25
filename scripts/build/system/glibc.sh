VERSION=${VERSION-2.17}

wget -q --no-check-certificate "http://ftp.gnu.org/gnu/glibc/glibc-$VERSION.tar.xz"
rm -rf glibc-$VERSION && tar -Jxf "glibc-$VERSION.tar.xz"
rm -f "glibc-$VERSION.tar.xz"
cd glibc-$VERSION

cd ..
rm -rf glibc-build
mkdir glibc-build
cd glibc-build

../glibc-$VERSION/configure\
    --prefix=/usr\
    --disable-profile\
    --enable-kernel=2.6.25\
    --libexecdir=/usr/lib/glibc

make
make -k check 2>&1 | tee glibc-check-log
grep Error glibc-check-log

touch /etc/ld.so.conf
make install
