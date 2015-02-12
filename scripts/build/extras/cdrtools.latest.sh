VERSION=${VERSION-3.01a27}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/cdrtools/alpha/cdrtools-$VERSION.tar.gz"
rm -rf cdrtools-$VERSION && tar -zxf "cdrtools-$VERSION.tar.gz"
rm -f "cdrtools-$VERSION.tar.gz"
cd cdrtools-$VERSION

make GMAKE_NOWARN=true && make install INS_BASE=$PREFIX GMAKE_NOWARN=true
