VERSION=${VERSION-8.45}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://downloads.sourceforge.net/pcre/pcre-$VERSION.tar.gz?use_mirror=netix" "--output-document=pcre-$VERSION.tar.gz"
rm -rf pcre-$VERSION && tar -zxf "pcre-$VERSION.tar.gz"
rm -f "pcre-$VERSION.tar.gz"
cd pcre-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX --enable-unicode-properties
make && make install
