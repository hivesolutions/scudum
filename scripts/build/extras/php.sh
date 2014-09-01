VERSION=${VERSION-5.4.15}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget --no-check-certificate "http://downloads.php.net/stas/php-$VERSION.tar.gz" "--output-document=php-$VERSION.tar.gz"
rm -rf php-$VERSION && tar -zxf "php-$VERSION.tar.gz"
rm -f "php-$VERSION.tar.gz"
cd php-$VERSION

./configure --prefix=$PREFIX --enable-embed
make && make install
