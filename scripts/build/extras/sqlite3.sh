VERSION=${VERSION-3530400}
YEAR=${YEAR-2026}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

if [ -z "$CFLAGS" ]; then export CFLAGS="-O2"; fi
export CFLAGS="$CFLAGS -DSQLITE_ENABLE_FTS3=1\
    -DSQLITE_ENABLE_COLUMN_METADATA=1\
    -DSQLITE_ENABLE_UNLOCK_NOTIFY=1\
    -DSQLITE_SECURE_DELETE=1"

rget "https://mirrors.hive.pt/mirrors/scudum/sqlite3/$VERSION/sqlite-autoconf-$VERSION.tar.gz"\
    "https://www.sqlite.org/$YEAR/sqlite-autoconf-$VERSION.tar.gz"\
    "https://www2.sqlite.org/$YEAR/sqlite-autoconf-$VERSION.tar.gz"
rm -rf sqlite-autoconf-$VERSION && tar -zxf "sqlite-autoconf-$VERSION.tar.gz"
rm -f "sqlite-autoconf-$VERSION.tar.gz"
cd sqlite-autoconf-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=$PREFIX\
    --soname=legacy\
    --enable-fts4\
    --enable-fts5\
    --enable-rtree
make && make install
