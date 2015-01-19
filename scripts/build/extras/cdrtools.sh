VERSION=${VERSION-3.01a26}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/cdrtools/alpha/cdrtools-$VERSION.tar.gz"
rm -rf cdrtools-$VERSION && tar -zxf "cdrtools-$VERSION.tar.gz"
rm -f "cdrtools-$VERSION.tar.gz"
cd cdrtools-$VERSION

make GMAKE_NOWARN=true && make install PREFIX=$PREFIX GMAKE_NOWARN=true

ln -s ../schily/bin/mkisofs $PREFIX/bin/mkisofs
ln -s ../schily/bin/cdrecord $PREFIX/bin/cdrecord
