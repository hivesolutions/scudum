VERSION="451"
tar -zxf "less-$VERSION.tar.gz"
cd less-$VERSION

./configure --prefix=/usr --sysconfdir=/etc
make && make install

cd ..
rm -rf less-$VERSION
