VERSION=${VERSION-3.00}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://netcologne.dl.sourceforge.net/project/cdrtools/cdrtools-$VERSION.tar.gz"
rm -rf cdrtools-$VERSION && tar -zxf "cdrtools-$VERSION.tar.gz"
rm -f "cdrtools-$VERSION.tar.gz"
cd cdrtools-$VERSION

make clean GMAKE_NOWARN=true || true
make GMAKE_NOWARN=true && make install INS_BASE=$PREFIX GMAKE_NOWARN=true
