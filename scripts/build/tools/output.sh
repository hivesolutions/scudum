set -e +h

echo "export SCUDUM_HOST=$SCUDUM_HOST" >> $SCUDUM/config
echo "export SCUDUM_ARCH=$SCUDUM_ARCH" >> $SCUDUM/config
echo "export SCUDUM_VENDOR=$SCUDUM_VENDOR" >> $SCUDUM/config
echo "export SCUDUM_SYSTEM=$SCUDUM_SYSTEM" >> $SCUDUM/config
echo "export SCUDUM_SYSTEM_H=$SCUDUM_SYSTEM_H" >> $SCUDUM/config
echo "export SCUDUM_MARCH=$SCUDUM_MARCH" >> $SCUDUM/config
echo "export SCUDUM_TARGET=$SCUDUM_TARGET" >> $SCUDUM/config
echo "export SCUDUM_CROSS=$SCUDUM_CROSS" >> $SCUDUM/config
echo "export SCUDUM_CROSS_COPY=$SCUDUM_CROSS_COPY" >> $SCUDUM/config
echo "export ARCH_TARGET=$ARCH_TARGET" >> $SCUDUM/config

[ "$GCC_BUILD_ARCH" != "" ] && echo "export GCC_BUILD_ARCH=$GCC_BUILD_ARCH" >> $SCUDUM/config || true
[ "$GCC_BUILD_CPU" != "" ] && echo "export GCC_BUILD_CPU=$GCC_BUILD_CPU" >> $SCUDUM/config || true
[ "$GCC_BUILD_TUNE" != "" ] && echo "export GCC_BUILD_TUNE=$GCC_BUILD_TUNE" >> $SCUDUM/config || true
[ "$GCC_BUILD_FPU" != "" ] && echo "export GCC_BUILD_FPU=$GCC_BUILD_FPU" >> $SCUDUM/config || true
[ "$GCC_BUILD_FLOAT" != "" ] && echo "export GCC_BUILD_FLOAT=$GCC_BUILD_FLOAT" >> $SCUDUM/config || true

chmod +x $SCUDUM/config
