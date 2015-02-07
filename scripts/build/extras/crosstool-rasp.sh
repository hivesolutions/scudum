DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

unset LD_LIBRARY_PATH
unset LIBRARY_PATH
unset C_INCLUDE_PATH
unset CPLUS_INCLUDE_PATH
unset MANPATH
unset PKG_CONFIG_PATH

depends "crosstool-ng"

mkdir crosstool-rasp

cat > defconfig << "EOF"
CT_PREFIX_DIR="/opt/${CT_TARGET}"
CT_ARCH_FPU="vfp"
CT_ARCH_FLOAT_HW=y
CT_ARCH_arm=y
CT_TARGET_VENDOR="rasp"
CT_KERNEL_linux=y
CT_CC_V_4_9_1=y
CT_LIBC_glibc=y
CT_CC_LANG_CXX=y
EOF

ct-ng defconfig
CT_ALLOW_BUILD_AS_ROOT_SURE=1 ct-ng build
