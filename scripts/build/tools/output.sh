set -e +h

cat > $SCUDUM/tools/config << "EOF"
export SCUDUM=$SCUDUM
export SCUDUM_HOST=$SCUDUM_HOST
export SCUDUM_ARCH=$SCUDUM_ARCH
export SCUDUM_VENDOR=$SCUDUM_VENDOR
export SCUDUM_SYSTEM=$SCUDUM_SYSTEM
export SCUDUM_SYSTEM_H=$SCUDUM_SYSTEM_H
export SCUDUM_MARCH=$SCUDUM_MARCH
export SCUDUM_TARGET=$SCUDUM_TARGET
export ARCH_TARGET=$ARCH_TARGET
EOF
