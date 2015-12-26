VERSION=${VERSION-1.16}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://rpm5.org/files/popt/popt-$VERSION.tar.gz"
rm -rf popt-$VERSION && tar -zxf "popt-$VERSION.tar.gz"
rm -f "popt-$VERSION.tar.gz"
cd popt-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    ./configure --host=$ARCH_TARGET --prefix=$PREFIX
else
    ./configure --prefix=$PREFIX
fi

make && make install
