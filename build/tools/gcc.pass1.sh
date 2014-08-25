VERSION=${VERSION-4.7.4}

wget -q "http://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2"
rm -rf gcc-$VERSION && tar -jxf "gcc-$VERSION.tar.bz2"
rm -f "gcc-$VERSION.tar.bz2"
cd gcc-$VERSION

# downloads all the requirements for the current gcc builds
# should as required by the current build system strategy
./contrib/download_prerequisites

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

sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure

cd ..
rm -rf gcc-build
mkdir gcc-build
cd gcc-build

../gcc-$VERSION/configure\
    --target=$SCUDUM_TARGET\
    --prefix=/tools\
    --with-sysroot=$SCUDUM\
    --with-newlib\
    --without-headers\
    --with-local-prefix=/tools\
    --with-native-system-header-dir=/tools/include\
    --disable-nls\
    --disable-shared\
    --disable-multilib\
    --disable-decimal-float\
    --disable-threads\
    --disable-libmudflap\
    --disable-libssp\
    --disable-libgomp\
    --disable-libquadmath\
    --enable-languages=c

make && make install
ln -sv libgcc.a `$SCUDUM_TARGET-gcc -print-libgcc-file-name | sed 's/libgcc/&_eh/'`

rm -rf gcc-$VERSION
