VERSION=${VERSION-1.5}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/gzip/gzip-$VERSION.tar.xz"
rm -rf gzip-$VERSION && tar -Jxf "gzip-$VERSION.tar.xz"
rm -f "gzip-$VERSION.tar.xz"
cd gzip-$VERSION

./configure --prefix=/usr --bindir=/bin

make
test $TEST && make check
make install

mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin
