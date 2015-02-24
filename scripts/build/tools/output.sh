set -e +h

variables="export SCUDUM=$SCUDUM\n\
export SCUDUM_HOST=$SCUDUM_HOST\n\
export SCUDUM_ARCH=$SCUDUM_ARCH\n\
export SCUDUM_VENDOR=$SCUDUM_VENDOR\n\
export SCUDUM_SYSTEM=$SCUDUM_SYSTEM\n\
export SCUDUM_SYSTEM_H=$SCUDUM_SYSTEM_H\n\
export SCUDUM_MARCH=$SCUDUM_MARCH\n\
export SCUDUM_TARGET=$SCUDUM_TARGET\n\
export SCUDUM_CROSS_COPY=$SCUDUM_CROSS_COPY\n\
export ARCH_TARGET=$ARCH_TARGET"

echo -e $variables > $SCUDUM/tools/config

chmod +x $SCUDUM/tools/config
