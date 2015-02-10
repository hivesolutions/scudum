VERSION=${VERSION-2.20}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat"

wget "http://cpan.org/authors/id/G/GR/GRANTM/XML-Simple-$VERSION.tar.gz"
rm -rf XML-Simple-$VERSION && tar -zxf "XML-Simple-$VERSION.tar.gz"
rm -f "XML-Simple-$VERSION.tar.gz"
cd XML-Simple-$VERSION

if [ "$PREFIX" == "/usr" ]; then
    perl Makefile.PL
else
    perl Makefile.PL PREFIX=$PREFIX LIB=$PREFIX/lib/perl5 EXPATLIBPATH=$PREFIX/lib
fi

make && make install
