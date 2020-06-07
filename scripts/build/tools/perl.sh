VERSION=${VERSION-5.30.3}
VERSION_MAJOR=${VERSION_MAJOR-5.0}

set -e +h

wget --content-disposition "http://www.cpan.org/src/$VERSION_MAJOR/perl-$VERSION.tar.gz"

rm -rf perl-$VERSION && tar -zxf "perl-$VERSION.tar.gz"
rm -f "perl-$VERSION.tar.gz"
cd perl-$VERSION

sh Configure -des -Dprefix=$PREFIX -Dlibs=-lm
make
cp -v perl cpan/podlators/scripts/pod2man $PREFIX/bin
mkdir -pv $PREFIX/lib/perl5/$VERSION
cp -Rv lib/* $PREFIX/lib/perl5/$VERSION
mkdir -pv $PREFIX/lib/perl5/$VERSION/pod
cp -Rv pod/* $PREFIX/lib/perl5/$VERSION/pod
