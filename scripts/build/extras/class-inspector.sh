VERSION=${VERSION-1.36}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://mirrors.hive.pt/mirrors/scudum/class-inspector/$VERSION/Class-Inspector-$VERSION.tar.gz"\
    "https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/Class-Inspector-$VERSION.tar.gz"\
    "https://www.cpan.org/authors/id/P/PL/PLICEASE/Class-Inspector-$VERSION.tar.gz"
rm -rf Class-Inspector-$VERSION && tar -zxf "Class-Inspector-$VERSION.tar.gz"
rm -f "Class-Inspector-$VERSION.tar.gz"
cd Class-Inspector-$VERSION

if [ "$PREFIX" == "/usr" ]; then
    perl Makefile.PL
else
    perl Makefile.PL PREFIX=$PREFIX LIB=$PREFIX/lib/perl5
fi

make && make install
