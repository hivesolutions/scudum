VERSION=${VERSION-2.44}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/glibc/$VERSION/glibc-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/glibc/glibc-$VERSION.tar.xz"
rget "https://mirrors.hive.pt/mirrors/scudum/glibc/$VERSION/glibc-fhs-1.patch"\
    "https://www.linuxfromscratch.org/patches/lfs/13.1/glibc-fhs-1.patch"
rget "https://mirrors.hive.pt/mirrors/scudum/glibc/$VERSION/glibc-$VERSION-upstream_fixes-1.patch"\
    "https://www.linuxfromscratch.org/patches/lfs/13.1/glibc-$VERSION-upstream_fixes-1.patch"
rm -rf glibc-$VERSION && tar -Jxf "glibc-$VERSION.tar.xz"
rm -f "glibc-$VERSION.tar.xz"
cd glibc-$VERSION

patch -Np1 -i ../glibc-fhs-1.patch
patch -Np1 -i ../glibc-$VERSION-upstream_fixes-1.patch

case $SCUDUM_HOST in
    x86_64)
        ln -sfv ../lib/ld-linux-x86-64.so.2 $SCUDUM/lib64
        ln -sfv ../lib/ld-linux-x86-64.so.2 $SCUDUM/lib64/ld-lsb-x86-64.so.3
    ;;
esac

cd ..
rm -rf glibc-build && mkdir glibc-build
cd glibc-build

echo "rootsbindir=/usr/sbin" > configparms

../glibc-$VERSION/configure\
    --prefix=/usr\
    --host=$SCUDUM_TARGET\
    --build=$(../glibc-$VERSION/scripts/config.guess)\
    --$GCC_MULTIARCH-multi-arch\
    --disable-nscd\
    --enable-kernel=5.10\
    libc_cv_slibdir=/usr/lib

make && make DESTDIR=$SCUDUM install

sed '/RTLDLIST=/s@/usr@@g' -i $SCUDUM/usr/bin/ldd

echo "int main(){}" > dummy.c && $SCUDUM_TARGET-gcc dummy.c
readelf -l a.out | grep ": /lib" && rm -v dummy.c a.out
