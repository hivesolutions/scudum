VERSION=${VERSION-5.35}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "ftp://ftp.astron.com/pub/file/file-$VERSION.tar.gz"\
    "https://src.fedoraproject.org/lookaside/pkgs/file/file-$VERSION.tar.gz
rm -rf file-$VERSION && tar -zxf "file-$VERSION.tar.gz"
rm -f "file-$VERSION.tar.gz"
cd file-$VERSION

./configure --prefix=$PREFIX
make && make install
