VERSION=${VERSION-3.14.7}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "sqlite3" "pcre" "libffi" "openssl.latest"

rget "https://mirrors.hive.pt/mirrors/scudum/python3/$VERSION/Python-$VERSION.tar.xz"\
    "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz"
rm -rf Python-$VERSION && tar -Jxf "Python-$VERSION.tar.xz"
rm -f "Python-$VERSION.tar.xz"
cd Python-$VERSION

./configure --prefix=$PREFIX --enable-shared
make && make install
