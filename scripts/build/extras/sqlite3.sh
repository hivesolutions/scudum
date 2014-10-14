VERSION=${VERSION-3080600}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

export CFLAGS="$CFLAGS -DSQLITE_ENABLE_FTS3=1\
    -DSQLITE_ENABLE_COLUMN_METADATA=1\
    -DSQLITE_ENABLE_UNLOCK_NOTIFY=1\
    -DSQLITE_SECURE_DELETE=1"

wget "http://www.sqlite.org/2014/sqlite-autoconf-$VERSION.tar.gz"
rm -rf sqlite-autoconf-$VERSION && tar -zxf "sqlite-autoconf-$VERSION.tar.gz"
rm -f "sqlite-autoconf-$VERSION.tar.gz"
cd sqlite-autoconf-$VERSION

./configure --prefix=$PREFIX
make && make install
