VERSION="5.16.2"
VERSION_MAJOR="5.0"

wget -q "http://www.cpan.org/src/$VERSION_MAJOR/perl-$VERSION.tar.bz2"
tar -jxf "perl-$VERSION.tar.bz2"
rm -f "perl-$VERSION.tar.bz2"
cd perl-$VERSION

wget -q "http://www.linuxfromscratch.org/patches/lfs/7.3/perl-$VERSION-libc-1.patch"
patch -Np1 -i perl-$VERSION-libc-1.patch

sh Configure -des -Dprefix=$PREFIX
make
cp -v perl cpan/podlators/pod2man $PREFIX/bin
mkdir -pv $PREFIX/lib/perl5/$VERSION
cp -Rv lib/* $PREFIX/lib/perl5/$VERSION
