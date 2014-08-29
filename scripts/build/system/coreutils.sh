VERSION=${VERSION-8.21}

set -e

wget --no-check-certificate "http://ftp.gnu.org/gnu/coreutils/coreutils-$VERSION.tar.xz"
rm -rf coreutils-$VERSION && tar -Jxf "coreutils-$VERSION.tar.xz"
rm -f "coreutils-$VERSION.tar.xz"
cd coreutils-$VERSION

wget --no-check-certificate http://www.linuxfromscratch.org/patches/lfs/7.3/coreutils-$VERSION-i18n-1.patch
patch -Np1 -i coreutils-$VERSION-i18n-1.patch

FORCE_UNSAFE_CONFIGURE=1 ./configure\
    --prefix=/usr\
    --libexecdir=/usr/lib\
    --enable-no-install-program=kill,uptime

make
make NON_ROOT_USERNAME=nobody check-root
echo "dummy:x:1000:nobody" >> /etc/group
chown -Rv nobody .

test $TEST && su nobody -s /bin/bash\
    -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"

sed -i '/dummy/d' /etc/group

make install

cp -p /usr/bin/mv /bin
mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin && sync
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,pwd,rm} /bin && sync
mv -v /usr/bin/{rmdir,stty,sync,true,uname,test,[} /bin && sync
mv -v /usr/bin/{head,sleep,nice} /bin && sync
mv -v /usr/bin/chroot /usr/sbin && sync
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8 && sync
rm /usr/bin/mv

sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8
