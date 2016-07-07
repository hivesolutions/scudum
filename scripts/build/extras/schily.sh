VERSION=${VERSION-2014-06-12}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/schilytools/schily-$VERSION.tar.bz2"
rm -rf schily-$VERSION && tar -jxf "schily-$VERSION.tar.bz2"
rm -f "schily-$VERSION.tar.bz2"
cd schily-$VERSION

make && make install PREFIX=$PREFIX

ln -svf ../schily/bin/smake $PREFIX/bin/smake
ln -svf ../schily/bin/mkisofs $PREFIX/bin/mkisofs
ln -svf ../schily/bin/isoinfo $PREFIX/bin/isoinfo
ln -svf ../schily/bin/isodump $PREFIX/bin/isodump
ln -svf ../schily/bin/isodebug $PREFIX/bin/isodebug
ln -svf ../schily/bin/cdrecord $PREFIX/bin/cdrecord
