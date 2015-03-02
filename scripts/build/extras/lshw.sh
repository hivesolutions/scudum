VERSION=${VERSION-B.02.17}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.ezix.org/software/files/lshw-$VERSION.tar.gz"
rm -rf lshw-$VERSION && tar -zxf "lshw-$VERSION.tar.gz"
rm -f "lshw-$VERSION.tar.gz"
cd lshw-$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    make CC=$CC CXX=$CXX CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" && make install PREFIX=$PREFIX
else
    make && make install PREFIX=$PREFIX
fi
