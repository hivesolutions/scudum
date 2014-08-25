VERSION="1.5"
tar -Jxf "gzip-$VERSION.tar.xz"
cd gzip-$VERSION

./configure --prefix=/usr --bindir=/bin
make
test $TEST && make check
make install

mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin

cd ..
rm -rf gzip-$VERSION
