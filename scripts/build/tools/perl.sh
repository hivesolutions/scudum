VERSION=${VERSION-5.20.1}
VERSION_MAJOR=${VERSION_MAJOR-5.0}

set -e +h

wget "http://www.cpan.org/src/$VERSION_MAJOR/perl-$VERSION.tar.bz2"
rm -rf perl-$VERSION && tar -jxf "perl-$VERSION.tar.bz2"
rm -f "perl-$VERSION.tar.bz2"
cd perl-$VERSION

sh Configure -des -Dprefix=$PREFIX -Dlibs=-lm
make
cp -v perl cpan/podlators/pod2man $PREFIX/bin
mkdir -pv $PREFIX/lib/perl5/$VERSION
cp -Rv lib/* $PREFIX/lib/perl5/$VERSION
mkdir -pv $PREFIX/lib/perl5/$VERSION/pod
cp -Rv pod/* $PREFIX/lib/perl5/$VERSION/pod
