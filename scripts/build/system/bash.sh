VERSION=${VERSION-4.3}
VERSION_L=${VERSION_L-43}
PATCH_SEQ=${PATCH_SEQ-1 42}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/bash/bash-$VERSION.tar.gz"
rm -rf bash-$VERSION && tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

for index in $(seq -f "%03g" $PATCH_SEQ); do
    wget --no-check-certificate http://ftp.gnu.org/gnu/bash/bash-$VERSION-patches/bash$VERSION_L-$index
    patch -Np0 -i bash$VERSION_L-$index
done

if [ "$SCUDUM_CROSS" == "1" ]; then
    test ! -e /bin/bash.old && cp -p /bin/bash /bin/bash.old || true
    ln -sf bash.old /bin/sh
fi

if [ "$SCUDUM_CROSS" == "1" ]; then
    ac_cv_rl_version=6.3\
    bash_cv_sys_siglist=yes\
    bash_cv_under_sys_siglist=yes\
    bash_cv_wexitstatus_offset=8\
    bash_cv_ulimit_maxfds=yes\
    bash_cv_func_sigsetjmp=present\
    bash_cv_job_control_missing=present\
    bash_cv_sys_named_pipes=present\
    bash_cv_getcwd_malloc=yes\
    bash_cv_printf_a_format=yes\
    bash_cv_unusable_rtsigs=no\
    ./configure\
        --host=$ARCH_TARGET\
        --prefix=/usr\
        --bindir=/bin\
        --htmldir=/usr/share/doc/bash-$VERSION\
        --without-bash-malloc\
        --with-installed-readline
else
    ./configure\
        --host=$ARCH_TARGET\
        --prefix=/usr\
        --bindir=/bin\
        --htmldir=/usr/share/doc/bash-$VERSION\
        --without-bash-malloc\
        --with-installed-readline
fi

make

chown -Rv nobody .
test $TEST && su nobody -s /bin/bash -c "PATH=$PATH make tests"
make install

ln -svf /bin/sh /usr/bin/sh
ln -svf /bin/bash /usr/bin/bash
