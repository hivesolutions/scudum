VERSION=${VERSION-0.6.21}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://downloads.sourceforge.net/libexif/libexif-$VERSION.tar.gz?use_mirror=netix" "--output-document=libexif-$VERSION.tar.gz"
rm -rf libexif-$VERSION && tar -zxf "libexif-$VERSION.tar.gz"
rm -f "libexif-$VERSION.tar.gz"
cd libexif-$VERSION

./configure --prefix=$PREFIX
make && make install
