VERSION=${VERSION-4.0.18}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

wget "http://ftp.gnu.org/gnu/mtools/mtools-$VERSION.tar.gz"
rm -rf mtools-$VERSION && tar -zxf "mtools-$VERSION.tar.gz"
rm -f "mtools-$VERSION.tar.gz"
cd mtools-$VERSION

./configure --prefix=$PREFIX
make && make install
