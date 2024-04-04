VERSION=${VERSION-0.6.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://sourceware.org/ftp/docbook-tools/new-trials/SOURCES/sgml-common-$VERSION.tgz"\
    "ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/sgml-common-$VERSION.tgz"\
    "ftp://ftp.edu.ee/gentoo/distfiles/sgml-common-$VERSION.tgz"
rm -rf sgml-common-$VERSION && tar -zxf "sgml-common-$VERSION.tgz"
rm -f "sgml-common-$VERSION.tgz"
cd sgml-common-$VERSION

#wget --content-disposition "https://lfs.mirror.fileplanet.com/patches/downloads/sgml-common/sgml-common-0.6.3-manpage-1.patch"
#patch -Np1 -i sgml-common-$VERSION-manpage-1.patch

autoreconf -f -i
./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install

make docdir=$PREFIX/share/doc install

install-catalog --add /etc/sgml/sgml-ent.cat\
    $PREFIX/share/sgml/sgml-iso-entities-8879.1986/catalog

install-catalog --add /etc/sgml/sgml-docbook.cat\
    /etc/sgml/sgml-ent.cat
