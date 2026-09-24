VERSION=${VERSION-5.3}
VERSION_L=${VERSION_L-53}
PATCH_SEQ=${PATCH_SEQ-1 20}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/bash/$VERSION/bash-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/bash/bash-$VERSION.tar.gz"
rm -rf bash-$VERSION && tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

for index in $(seq -f "%03g" $PATCH_SEQ); do
    rgeti "https://mirrors.hive.pt/mirrors/scudum/bash/$VERSION/bash$VERSION_L-$index"\
        "https://ftpmirror.gnu.org/bash/bash-$VERSION-patches/bash$VERSION_L-$index"
    patch -Np0 -i bash$VERSION_L-$index
done

if [ "$SCUDUM_CROSS" == "1" ]; then
    test ! -e /bin/bash.old && cp -p /bin/bash /bin/bash.old || true
    ln -sf bash.old /bin/sh
fi

if [ "$SCUDUM_CROSS" == "1" ]; then
    ac_cv_rl_version=8.3\
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
        --docdir=/usr/share/doc/bash-$VERSION\
        --without-bash-malloc\
        --with-installed-readline
else
    ./configure\
        --host=$ARCH_TARGET\
        --prefix=/usr\
        --docdir=/usr/share/doc/bash-$VERSION\
        --without-bash-malloc\
        --with-installed-readline
fi

make

chown -Rv nobody .
test $TEST && su nobody -s /bin/bash -c "PATH=$PATH make tests"
make install

echo "/bin/sh" >> /etc/shells
echo "/bin/bash" >> /etc/shells
