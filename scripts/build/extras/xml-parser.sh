VERSION=${VERSION-2.42_01}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat"

wget --content-disposition "http://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-$VERSION.tar.gz"
rm -rf XML-Parser-$VERSION && tar -zxf "XML-Parser-$VERSION.tar.gz"
rm -f "XML-Parser-$VERSION.tar.gz"
cd XML-Parser-$VERSION

if [ "$PREFIX" == "/usr" ]; then
    perl Makefile.PL
else
    perl Makefile.PL PREFIX=$PREFIX LIB=$PREFIX/lib/perl5 EXPATLIBPATH=$PREFIX/lib
fi

make && make install
