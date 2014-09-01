VERSION=${VERSION-5.4.15}

set -e +h

wget --no-check-certificate "http://downloads.php.net/stas/php-$VERSION.tar.gz" "--output-document=php-$VERSION.tar.gz"
tar -zxf "php-$VERSION.tar.gz"
rm -f "php-$VERSION.tar.gz"
cd php-$VERSION

./configure --enable-embed
make && make install
