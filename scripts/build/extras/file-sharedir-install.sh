VERSION=${VERSION-0.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "https://mirrors.hive.pt/mirrors/scudum/file-sharedir-install/$VERSION/File-ShareDir-Install-$VERSION.tar.gz"\
    "https://cpan.metacpan.org/authors/id/E/ET/ETHER/File-ShareDir-Install-$VERSION.tar.gz"\
    "https://www.cpan.org/authors/id/E/ET/ETHER/File-ShareDir-Install-$VERSION.tar.gz"
rm -rf File-ShareDir-Install-$VERSION && tar -zxf "File-ShareDir-Install-$VERSION.tar.gz"
rm -f "File-ShareDir-Install-$VERSION.tar.gz"
cd File-ShareDir-Install-$VERSION

if [ "$PREFIX" == "/usr" ]; then
    perl Makefile.PL
else
    perl Makefile.PL PREFIX=$PREFIX LIB=$PREFIX/lib/perl5
fi

make && make install
