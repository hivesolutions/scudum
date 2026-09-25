VERSION=${VERSION-3.14.7}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/python3/$VERSION/Python-$VERSION.tar.xz"\
    "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz"
rm -rf Python-$VERSION && tar -Jxf "Python-$VERSION.tar.xz"
rm -f "Python-$VERSION.tar.xz"
cd Python-$VERSION

./configure\
    --prefix=/usr\
    --enable-shared\
    --without-ensurepip\
    --without-static-libpython

make && make install
