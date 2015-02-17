VERSION=${VERSION-22.20}

set -e +h

export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

wget --no-check-certificate "http://downloads.sourceforge.net/psmisc/psmisc-$VERSION.tar.gz"
rm -rf psmisc-$VERSION && tar -zxf "psmisc-$VERSION.tar.gz"
rm -f "psmisc-$VERSION.tar.gz"
cd psmisc-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make && make install

mv -v /usr/bin/fuser /bin
mv -v /usr/bin/killall /bin
