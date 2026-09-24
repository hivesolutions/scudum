VERSION=${VERSION-2.59}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat" "file-sharedir-install" "file-sharedir"

rget "https://mirrors.hive.pt/mirrors/scudum/xml-parser/$VERSION/XML-Parser-$VERSION.tar.gz"\
    "https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-$VERSION.tar.gz"\
    "https://www.cpan.org/authors/id/T/TO/TODDR/XML-Parser-$VERSION.tar.gz"
rm -rf XML-Parser-$VERSION && tar -zxf "XML-Parser-$VERSION.tar.gz"
rm -f "XML-Parser-$VERSION.tar.gz"
cd XML-Parser-$VERSION

if [ "$PREFIX" != "/usr" ]; then
    export PERL5LIB=$PREFIX/lib/perl5${PERL5LIB:+:$PERL5LIB}
fi

if [ "$PREFIX" == "/usr" ]; then
    perl Makefile.PL
else
    perl Makefile.PL PREFIX=$PREFIX LIB=$PREFIX/lib/perl5 EXPATLIBPATH=$PREFIX/lib
fi

make && make install
