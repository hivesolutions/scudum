VERSION=${VERSION-2014-06-12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/schilytools/schily-$VERSION.tar.bz2"
rm -rf schily-$VERSION && tar -jxf "schily-$VERSION.tar.bz2"
rm -f "schily-$VERSION.tar.bz2"
cd schily-$VERSION

make && make install PREFIX=$PREFIX

ln -sv ../schily/bin/smake $PREFIX/bin/smake
ln -sv ../schily/bin/mkisofs $PREFIX/bin/mkisofs
ln -sv ../schily/bin/isoinfo $PREFIX/bin/isoinfo
ln -sv ../schily/bin/isodump $PREFIX/bin/isodump
ln -sv ../schily/bin/isodebug $PREFIX/bin/isodebug
ln -sv ../schily/bin/cdrecord $PREFIX/bin/cdrecord
