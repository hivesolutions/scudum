VERSION=${VERSION-latest}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

unset MAKEFLAGS

if [ "$VERSION" == "latest" ]; then
    rm -rf lshw && git clone --depth 1 "https://github.com/lyonel/lshw.git"
    cd lshw
else
    wget --content-disposition "http://www.ezix.org/software/files/lshw-$VERSION.tar.gz"
    rm -rf lshw-$VERSION && tar -zxf "lshw-$VERSION.tar.gz"
    rm -f "lshw-$VERSION.tar.gz"
    cd lshw-$VERSION
fi

if [ "$SCUDUM_CROSS" == "1" ]; then
    rm -rf docs
    make CXX="$CXX" && make install PREFIX=$PREFIX
else
    make && make install PREFIX=$PREFIX
fi
