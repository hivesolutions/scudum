VERSION=${VERSION-5.44.0}
VERSION_MAJOR=${VERSION_MAJOR-5.0}
VERSION_L=${VERSION_L-5.44}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/perl/$VERSION/perl-$VERSION.tar.xz"\
    "https://www.cpan.org/src/$VERSION_MAJOR/perl-$VERSION.tar.xz"
rm -rf perl-$VERSION && tar -Jxf "perl-$VERSION.tar.xz"
rm -f "perl-$VERSION.tar.xz"
cd perl-$VERSION

sh Configure -des\
    -D prefix=/usr\
    -D vendorprefix=/usr\
    -D useshrplib\
    -D privlib=/usr/lib/perl5/$VERSION_L/core_perl\
    -D archlib=/usr/lib/perl5/$VERSION_L/core_perl\
    -D sitelib=/usr/lib/perl5/$VERSION_L/site_perl\
    -D sitearch=/usr/lib/perl5/$VERSION_L/site_perl\
    -D vendorlib=/usr/lib/perl5/$VERSION_L/vendor_perl\
    -D vendorarch=/usr/lib/perl5/$VERSION_L/vendor_perl

make && make install
