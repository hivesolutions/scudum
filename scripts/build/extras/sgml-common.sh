VERSION=${VERSION-0.6.3}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/sgml-common-$VERSION.tgz"
rm -rf sgml-common-$VERSION && tar -zxf "sgml-common-$VERSION.tgz"
rm -f "sgml-common-$VERSION.tgz"
cd sgml-common-$VERSION

autoreconf -f -i
./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install

make docdir=$PREFIX/share/doc install

install-catalog --add /etc/sgml/sgml-ent.cat\
    $PREFIX/share/sgml/sgml-iso-entities-8879.1986/catalog

install-catalog --add /etc/sgml/sgml-docbook.cat\
    /etc/sgml/sgml-ent.cat
