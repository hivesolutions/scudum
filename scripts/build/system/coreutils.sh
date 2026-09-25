VERSION=${VERSION-9.11}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/coreutils/$VERSION/coreutils-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/coreutils/coreutils-$VERSION.tar.xz"
rm -rf coreutils-$VERSION && tar -Jxf "coreutils-$VERSION.tar.xz"
rm -f "coreutils-$VERSION.tar.xz"
cd coreutils-$VERSION

FORCE_UNSAFE_CONFIGURE=1 ./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr

make

if [ $TEST ]; then
    make NON_ROOT_USERNAME=nobody check-root
    echo "dummy:x:1000:nobody" >> /etc/group
    chown -Rv nobody .

    su nobody -s /bin/bash\
    -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"

    sed -i '/dummy/d' /etc/group
fi

make install

mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8
