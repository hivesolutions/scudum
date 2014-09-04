VERSION=${VERSION-2.7.8}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "sqlite3" "pcre"

export CFLAGS="$CFLAGS -fpic"

wget "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz"
rm -rf Python-$VERSION && tar -zxf "Python-$VERSION.tgz"
rm -f "Python-$VERSION.tgz"
cd Python-$VERSION

./configure --prefix=$PREFIX
make && make install
