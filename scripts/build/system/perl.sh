VERSION=${VERSION-5.44.0}
VERSION_MAJOR=${VERSION_MAJOR-5.0}
VERSION_L=${VERSION_L-5.44}
VERSION_CROSS=${VERSION_CROSS-1.6.5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

export BUILD_ZLIB=False
export BUILD_BZIP2=0

rgeti "https://mirrors.hive.pt/mirrors/scudum/perl/$VERSION/perl-$VERSION.tar.xz"\
    "https://www.cpan.org/src/$VERSION_MAJOR/perl-$VERSION.tar.xz"
rm -rf perl-$VERSION && tar -Jxf "perl-$VERSION.tar.xz"
rm -f "perl-$VERSION.tar.xz"

if [ "$SCUDUM_CROSS" == "1" ]; then
    rgeti "https://mirrors.hive.pt/mirrors/scudum/perl-cross/$VERSION_CROSS/perl-cross-$VERSION_CROSS.tar.gz"\
        "https://github.com/arsv/perl-cross/releases/download/$VERSION_CROSS/perl-cross-$VERSION_CROSS.tar.gz"
    tar -zxf "perl-cross-$VERSION_CROSS.tar.gz" -C perl-$VERSION --strip-components=1
    rm -f "perl-cross-$VERSION_CROSS.tar.gz"
fi

cd perl-$VERSION

echo "127.0.0.1 localhost" > /etc/hosts

if [ "$SCUDUM_CROSS" == "1" ]; then
    CC="$ARCH_TARGET-gcc" CFLAGS="$EFLAGS"\
        ./configure --target=$ARCH_TARGET --prefix=/usr -Duseshrplib
else
    sh Configure -des -Dprefix=/usr\
        -Dvendorprefix=/usr\
        -Dprivlib=/usr/lib/perl5/$VERSION_L/core_perl\
        -Darchlib=/usr/lib/perl5/$VERSION_L/core_perl\
        -Dsitelib=/usr/lib/perl5/$VERSION_L/site_perl\
        -Dsitearch=/usr/lib/perl5/$VERSION_L/site_perl\
        -Dvendorlib=/usr/lib/perl5/$VERSION_L/vendor_perl\
        -Dvendorarch=/usr/lib/perl5/$VERSION_L/vendor_perl\
        -Dman1dir=/usr/share/man/man1\
        -Dman3dir=/usr/share/man/man3\
        -Dpager="/usr/bin/less -isR"\
        -Duseshrplib\
        -Dusethreads
fi

make
test $TEST && make -k test
make install
