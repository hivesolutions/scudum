VERSION=${VERSION-7.12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://nmap.org/dist/nmap-$VERSION.tar.bz2"
rm -rf nmap-$VERSION && tar -jxf "nmap-$VERSION.tar.bz2"
rm -f "nmap-$VERSION.tar.bz2"
cd nmap-$VERSION

./configure --prefix=$PREFIX
make && make install
