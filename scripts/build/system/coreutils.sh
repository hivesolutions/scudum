VERSION=${VERSION-8.21}

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

su nobody -s /bin/bash\
    -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"

sed -i '/dummy/d' /etc/group

make install

mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
mv -v /usr/bin/{rmdir,stty,sync,true,uname,test,[} /bin
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8

mv -v /usr/bin/{head,sleep,nice} /bin
