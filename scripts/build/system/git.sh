VERSION=${VERSION-2.3.1}

set -e +h

wget --no-check-certificate "https://www.kernel.org/pub/software/scm/git/git-$VERSION.tar.xz"
rm -rf git-$VERSION && tar -Jxf "git-$VERSION.tar.xz"
rm -f "git-$VERSION.tar.xz"
cd git-$VERSION

sed -i 's/as_fn_error ()/as_fn_error ()\n{\nreturn 0\n}\nold_as_fn_error ()\n/' configure

if [ "$SCUDUM_CROSS" == "1" ]; then
    ./configure --host=$ARCH_TARGET --prefix=/usr --with-perl=/tools/bin/perl
else
    ./configure --host=$ARCH_TARGET --prefix=/usr
fi

make && make install
