VERSION=${VERSION-451}

set -e +h

wget --no-check-certificate "http://www.greenwoodsoftware.com/less/less-$VERSION.tar.gz"
rm -rf less-$VERSION && tar -zxf "less-$VERSION.tar.gz"
rm -f "less-$VERSION.tar.gz"
cd less-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --sysconfdir=/etc

make && make install
