VERSION=${VERSION-3.3.6}

set -e

wget --no-check-certificate "http://sourceforge.net/projects/procps-ng/files/Production/procps-ng-$VERSION.tar.xz"
rm -rf procps-ng-$VERSION && tar -Jxf "procps-ng-$VERSION.tar.xz"
rm -f "procps-ng-$VERSION.tar.xz"
cd procps-ng-$VERSION

./configure\
    --prefix=/usr\
    --exec-prefix=\
    --libdir=/usr/lib\
    --docdir=/usr/share/doc/procps-ng-$VERSION\
    --disable-static\
    --disable-skill\
    --disable-kill
    
make

pushd testsuite
    sed -i -e 's|exec which sleep|exec echo /tools/bin/sleep|'\
        -e 's|999999|&9|' config/unix.exp
    sed -i -e 's|pmap_initname\\\$|pmap_initname|' pmap.test/pmap.exp
    make site.exp
    DEJAGNU=global-conf.exp runtest
popd

make install

mv -v /usr/lib/libprocps.so.* /lib
ln -sfv ../../lib/libprocps.so.1.1.0 /usr/lib/libprocps.so
