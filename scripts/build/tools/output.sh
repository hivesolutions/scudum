set -e +h

base="export SCUDUM_HOST=$SCUDUM_HOST\n\
export SCUDUM_ARCH=$SCUDUM_ARCH\n\
export SCUDUM_VENDOR=$SCUDUM_VENDOR\n\
export SCUDUM_SYSTEM=$SCUDUM_SYSTEM\n\
export SCUDUM_SYSTEM_H=$SCUDUM_SYSTEM_H\n\
export SCUDUM_MARCH=$SCUDUM_MARCH\n\
export SCUDUM_TARGET=$SCUDUM_TARGET\n\
export SCUDUM_CROSS=$SCUDUM_CROSS\n\
export SCUDUM_CROSS_COPY=$SCUDUM_CROSS_COPY\n\
export ARCH_TARGET=$ARCH_TARGET"

echo -e $base > $SCUDUM/config

[ "$GCC_BUILD_ARCH" != "" ] && echo "export GCC_BUILD_ARCH=$GCC_BUILD_ARCH" >> $SCUDUM/config || true
[ "$GCC_BUILD_CPU" != "" ] && echo "export GCC_BUILD_CPU=$GCC_BUILD_CPU" >> $SCUDUM/config || true
[ "$GCC_BUILD_TUNE" != "" ] && echo "export GCC_BUILD_TUNE=$GCC_BUILD_TUNE" >> $SCUDUM/config || true
[ "$GCC_BUILD_FPU" != "" ] && echo "export GCC_BUILD_FPU=$GCC_BUILD_FPU" >> $SCUDUM/config || true
[ "$GCC_BUILD_FLOAT" != "" ] && echo "export GCC_BUILD_FLOAT=$GCC_BUILD_FLOAT" >> $SCUDUM/config || true

chmod +x $SCUDUM/config
