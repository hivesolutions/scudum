VERSION=${VERSION-0.7.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libelf"

if [ -z "$CFLAGS" ]; then export CFLAGS="-O2"; fi
if [ -z "$CXXFLAGS" ]; then export CXXFLAGS="-O2"; fi
export CFLAGS="$CFLAGS -Wno-unused-local-typedefs"
export CXXFLAGS="$CXXFLAGS -Wno-unused-local-typedefs"

wget "http://ltrace.org/ltrace_$VERSION.orig.tar.bz2"
rm -rf ltrace-$VERSION && tar -jxf "ltrace_$VERSION.orig.tar.bz2"
rm -f "ltrace_$VERSION.orig.tar.bz2"
cd ltrace-$VERSION

./configure --prefix=$PREFIX
make && make install
