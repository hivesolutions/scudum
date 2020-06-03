VERSION=${VERSION-23.2}

set -e +h

export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

wget --no-check-certificate --content-disposition "http://downloads.sourceforge.net/psmisc/psmisc-$VERSION.tar.xz?use_mirror=ayera"
rm -rf psmisc-$VERSION && tar -Jxf "psmisc-$VERSION.tar.xz"
rm -f "psmisc-$VERSION.tar.xz"
cd psmisc-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make && make install

mv -v /usr/bin/fuser /bin
mv -v /usr/bin/killall /bin
