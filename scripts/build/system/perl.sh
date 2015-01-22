VERSION=${VERSION-5.20.1}

set -e +h

wget --no-check-certificate "http://www.cpan.org/src/5.0/perl-$VERSION.tar.bz2"
rm -rf perl-$VERSION && tar -jxf "perl-$VERSION.tar.bz2"
rm -f "perl-$VERSION.tar.bz2"
cd perl-$VERSION

echo "127.0.0.1 localhost" > /etc/hosts

export BUILD_ZLIB=False
export BUILD_BZIP2=0

sh Configure -des -Dprefix=/usr\
    -Dvendorprefix=/usr\
    -Dman1dir=/usr/share/man/man1\
    -Dman3dir=/usr/share/man/man3\
    -Dpager="/usr/bin/less -isR"\
    Duseshrplib

make
test $TEST && make -k test
make install
