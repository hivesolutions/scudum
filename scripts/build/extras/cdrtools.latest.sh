VERSION=${VERSION-3.01a27}
VERSION_L=${VERSION_L-3.01}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/cdrtools/alpha/cdrtools-$VERSION.tar.gz"
rm -rf cdrtools-$VERSION_L && tar -zxf "cdrtools-$VERSION.tar.gz"
rm -f "cdrtools-$VERSION.tar.gz"
cd cdrtools-$VERSION_L

make clean GMAKE_NOWARN=true || true
make GMAKE_NOWARN=true && make install INS_BASE=$PREFIX GMAKE_NOWARN=true
