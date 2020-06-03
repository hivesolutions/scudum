VERSION=${VERSION-0.13.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "https://github.com/BurntSushi/xsv/releases/download/$VERSION/xsv-$VERSION-x86_64-unknown-linux-musl.tar.gz"
rm -rf xsv && tar -zxf "xsv-$VERSION-x86_64-unknown-linux-musl.tar.gz"
rm -f "xsv-$VERSION-x86_64-unknown-linux-musl.tar.gz"

mv xsv $PREFIX/bin
