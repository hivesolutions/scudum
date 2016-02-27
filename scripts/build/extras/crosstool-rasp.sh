DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "crosstool-ng"

unset LD_LIBRARY_PATH LIBRARY_PATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH\
    MANPATH PKG_CONFIG_PATH

mkdir crosstool-rasp

cat > defconfig << "EOF"
CT_PREFIX_DIR="/opt/${CT_TARGET}"
CT_ARCH_FPU="vfp"
CT_ARCH_FLOAT_HW=y
CT_ARCH_arm=y
CT_ARCH_ARCH="armv6zk"
CT_ARCH_CPU="arm1176jzf-s"
CT_ARCH_TUNE="arm1176jzf-s"
CT_TARGET_VENDOR="rasp"
CT_KERNEL_linux=y
CT_CC_GCC_V_5_2_0=y
CT_LIBC_glibc=y
CT_CC_LANG_CXX=y
EOF

ct-ng defconfig
CT_ALLOW_BUILD_AS_ROOT_SURE=1 ct-ng build
