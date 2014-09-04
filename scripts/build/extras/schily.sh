VERSION=${VERSION-2014-06-12}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/schilytools/schily-$VERSION.tar.bz2"
rm -rf schily-$VERSION && tar -jxf "schily-$VERSION.tar.bz2"
rm -f "schily-$VERSION.tar.bz2"
cd schily-$VERSION

make && make install PREFIX=$PREFIX

ln -s ../schily/bin/smake $PREFIX/bin/smake
ln -s ../schily/bin/mkisofs $PREFIX/bin/mkisofs
ln -s ../schily/bin/isoinfo $PREFIX/bin/isoinfo
ln -s ../schily/bin/isodump $PREFIX/bin/isodump
ln -s ../schily/bin/isodebug $PREFIX/bin/isodebug
