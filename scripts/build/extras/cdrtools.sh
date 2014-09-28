VERSION=${VERSION-3.00}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/cdrtools/cdrtools-$VERSION.tar.gz"
rm -rf cdrtools-$VERSION && tar -zxf "cdrtools-$VERSION.tar.gz"
rm -f "cdrtools-$VERSION.tar.gz"
cd cdrtools-$VERSION

make && make install PREFIX=$PREFIX

ln -s ../schily/bin/mkisofs $PREFIX/bin/mkisofs
ln -s ../schily/bin/cdrecord $PREFIX/bin/cdrecord
