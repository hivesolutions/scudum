VERSION=${VERSION-5.20.2}
VERSION_CROSS=${VERSION_CROSS-0.9.5}

set -e +h

export BUILD_ZLIB=False
export BUILD_BZIP2=0

wget --no-check-certificate "http://www.cpan.org/src/5.0/perl-$VERSION.tar.bz2"
rm -rf perl-$VERSION && tar -jxf "perl-$VERSION.tar.bz2"
rm -f "perl-$VERSION.tar.bz2"

if [ "$SCUDUM_CROSS" == "1" ]; then
    wget --no-check-certificate "https://raw.github.com/arsv/perl-cross/releases/perl-$VERSION-cross-$VERSION_CROSS.tar.gz"
    tar -zxf "perl-$VERSION-cross-$VERSION_CROSS.tar.gz"
    rm -f "perl-$VERSION-cross-$VERSION_CROSS.tar.gz"
fi

cd perl-$VERSION

echo "127.0.0.1 localhost" > /etc/hosts

if [ "$SCUDUM_CROSS" == "1" ]; then
    sed -i 's/which "$p" >&/dev/null/true/' cnf/configure_prog.sh
    ./configure --target=$ARCH_TARGET --prefix=/usr
else
    sh Configure -des -Dprefix=/usr\
        -Dvendorprefix=/usr\
        -Dman1dir=/usr/share/man/man1\
        -Dman3dir=/usr/share/man/man3\
        -Dpager="/usr/bin/less -isR"\
        Duseshrplib
fi

make
test $TEST && make -k test
make install
