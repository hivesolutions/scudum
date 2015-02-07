VERSION=${VERSION-0.7.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

export CFLAGS="-Wno-unused-local-typedefs"
export CXXFLAGS="-Wno-unused-local-typedefs"

depends "libelf"

wget "http://ltrace.org/ltrace_$VERSION.orig.tar.bz2"
rm -rf ltrace_$VERSION && tar -zxf "ltrace_$VERSION.orig.tar.bz2"
rm -f "ltrace_$VERSION.orig.tar.bz2"
cd ltrace_$VERSION

./configure --prefix=$PREFIX
make && make install
