VERSION=${VERSION-1.118}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "class-inspector"

rget "https://mirrors.hive.pt/mirrors/scudum/file-sharedir/$VERSION/File-ShareDir-$VERSION.tar.gz"\
    "https://cpan.metacpan.org/authors/id/R/RE/REHSACK/File-ShareDir-$VERSION.tar.gz"\
    "https://www.cpan.org/authors/id/R/RE/REHSACK/File-ShareDir-$VERSION.tar.gz"
rm -rf File-ShareDir-$VERSION && tar -zxf "File-ShareDir-$VERSION.tar.gz"
rm -f "File-ShareDir-$VERSION.tar.gz"
cd File-ShareDir-$VERSION

if [ "$PREFIX" != "/usr" ]; then
    export PERL5LIB=$PREFIX/lib/perl5${PERL5LIB:+:$PERL5LIB}
fi

if [ "$PREFIX" == "/usr" ]; then
    perl Makefile.PL
else
    perl Makefile.PL PREFIX=$PREFIX LIB=$PREFIX/lib/perl5
fi

make && make install
