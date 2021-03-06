VERSION=${VERSION-5.30.3}
VERSION_MAJOR=${VERSION_MAJOR-5.0}
VERSION_CROSS=${VERSION_CROSS-1.3.4}

set -e +h

export BUILD_ZLIB=False
export BUILD_BZIP2=0

wget --no-check-certificate --content-disposition "http://www.cpan.org/src/$VERSION_MAJOR/perl-$VERSION.tar.gz"
rm -rf perl-$VERSION && tar -zxf "perl-$VERSION.tar.gz"
rm -f "perl-$VERSION.tar.gz"

if [ "$SCUDUM_CROSS" == "1" ]; then
    wget --no-check-certificate --content-disposition "https://github.com/arsv/perl-cross/releases/download/$VERSION_CROSS/perl-cross-$VERSION_CROSS.tar.gz"
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
        -Dman1dir=/usr/share/man/man1\
        -Dman3dir=/usr/share/man/man3\
        -Dpager="/usr/bin/less -isR"\
        -Duseshrplib
fi

make
test $TEST && make -k test
make install
