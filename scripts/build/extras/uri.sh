VERSION=${VERSION-1.64}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "expat"

wget "http://www.cpan.org/authors/id/E/ET/ETHER/URI-$VERSION.tar.gz"
rm -rf URI-$VERSION && tar -zxf "URI-$VERSION.tar.gz"
rm -f "URI-$VERSION.tar.gz"
cd URI-$VERSION

if [ "$PREFIX" == "/usr" ]; then
    perl Makefile.PL
else
    perl Makefile.PL PREFIX=$PREFIX LIB=$PREFIX/lib/perl5 EXPATLIBPATH=$PREFIX/lib
fi

make && make install
