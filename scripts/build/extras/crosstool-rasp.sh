DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "crosstool-ng"

mkdir crosstool-rasp

cat > defconfig << "EOF"
CT_PREFIX_DIR="/opt/${CT_TARGET}"
CT_ARCH_FPU="vfp"
CT_ARCH_FLOAT_HW=y
CT_ARCH_arm=y
CT_TARGET_VENDOR="rasp"
CT_KERNEL_linux=y
CT_CC_V_4_8_3=y
CT_CC_LANG_CXX=y
EOF

ct-ng defconfig
CT_ALLOW_BUILD_AS_ROOT_SURE=1 ct-ng build
