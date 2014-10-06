VERSION=${VERSION-2.42_01}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat"

wget "http://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-$VERSION.tar.gz"
rm -rf XML-Parser-$VERSION && tar -zxf "XML-Parser-$VERSION.tar.gz"
rm -f "XML-Parser-$VERSION.tar.gz"
cd XML-Parser-$VERSION

perl Makefile.PL PREFIX=$PREFIX LIB=$PREFIX/lib/perl5
make && make install
