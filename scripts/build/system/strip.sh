source /config

if [ "$SCUDUM_CROSS" == "1" ]; then
    strip=/cross/bin/$ARCH_TARGET-strip
else
    strip=/usr/bin/strip
fi

# hard linked files are stripped in place, the others as copies renamed
# over the originals so that files in use (eg: libc) are never overwritten
find /usr/{bin,lib,libexec,sbin} -type f -links +1 -exec $strip --strip-debug '{}' ';'

for file in $(find /usr/{bin,lib,libexec,sbin} -type f -links 1\
    \( -perm -u+x -o -name "*.so*" -o -name "*.a" -o -name "*.o" \)); do
    cp -p $file $file.strip
    $strip --strip-debug $file.strip && mv -f $file.strip $file || rm -f $file.strip
done
