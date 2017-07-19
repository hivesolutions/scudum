VERSION=${VERSION-2.8.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

wget --no-check-certificate "http://ftp.gnu.org/pub/gnu/nano/nano-$VERSION.tar.gz"
rm -rf nano-$VERSION && tar -zxf "nano-$VERSION.tar.gz"
rm -f "nano-$VERSION.tar.gz"
cd nano-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr --enable-utf8

make && make install

ln -svf nano /usr/bin/pico
