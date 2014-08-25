VERSION="22.20"
tar -zxf "psmisc-$VERSION.tar.gz"
cd psmisc-$VERSION

./configure --prefix=/usr
make && make install

mv -v /usr/bin/fuser /bin
mv -v /usr/bin/killall /bin

cd ..
rm -rf psmisc-$VERSION
