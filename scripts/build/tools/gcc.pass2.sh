VERSION=${VERSION-4.8.3}

set -e

wget "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2"
rm -rf gcc-$VERSION && tar -jxf "gcc-$VERSION.tar.bz2"
rm -f "gcc-$VERSION.tar.bz2"
cd gcc-$VERSION

# downloads all the requirements for the current gcc builds
# should as required by the current build system strategy
./contrib/download_prerequisites

cat gcc/limitx.h gcc/glimits.h gcc/limity.h >\
    `dirname $($SCUDUM_TARGET-gcc -print-libgcc-file-name)`/include-fixed/limits.h

case `uname -m` in
    i?86) sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
esac

for file in $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
do
    cp -uv $file{,.orig}
    sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g'\
        -e 's@/usr@/tools@g' $file.orig > $file
    echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
    touch $file.orig
done

cd ..
rm -rf gcc-build
mkdir gcc-build
cd gcc-build

CC=$SCUDUM_TARGET-gcc AR=$SCUDUM_TARGET-ar RANLIB=$SCUDUM_TARGET-ranlib ../gcc-$VERSION/configure\
    --prefix=/tools\
    --with-local-prefix=/tools\
    --with-native-system-header-dir=/tools/include\
    --enable-clocale=gnu\
    --enable-shared\
    --enable-threads=posix\
    --enable-__cxa_atexit\
    --enable-languages=c,c++\
    --disable-libstdcxx-pch\
    --disable-multilib\
    --disable-bootstrap\
    --disable-libgomp

make && make install

ln -sv gcc /tools/bin/cc
