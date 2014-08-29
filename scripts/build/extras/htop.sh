VERSION=${VERSION-1.0.3}

set -e +h

wget --no-check-certificate "http://hisham.hm/htop/releases/$VERSION/htop-$VERSION.tar.gz"
rm -rf "htop-$VERSION" && tar -zxf "htop-$VERSION.tar.gz"
rm -f "htop-$VERSION.tar.gz"
cd htop-$VERSION

./configure --prefix=/usr

make && make install
