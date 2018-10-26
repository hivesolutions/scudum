DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "crosstool-ng"

unset LD_LIBRARY_PATH LIBRARY_PATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH\
    MANPATH PKG_CONFIG_PATH

rm -rf crosstool-rasp && mkdir crosstool-rasp
cd crosstool-rasp

cat > defconfig << "EOF"
CT_PREFIX_DIR="/opt/${CT_TARGET}"
CT_PATCH_BUNDLED_LOCAL=y
CT_LOCAL_PATCH_DIR="${CT_TOP_DIR}/patches"
CT_ARCH_FPU="vfp"
CT_ARCH_FLOAT_HW=y
CT_ARCH_arm=y
CT_ARCH_ARCH="armv6zk"
CT_ARCH_CPU="arm1176jzf-s"
CT_ARCH_TUNE="arm1176jzf-s"
CT_TARGET_VENDOR="rasp"
CT_KERNEL_linux=y
CT_CC_GCC_V_6_3_0=y
CT_LIBC_glibc=y
CT_CC_LANG_CXX=y
EOF

mkdir -p patches/gcc/6.3.0

cat > patches/gcc/6.3.0/gcc-6.3.0_fixup.patch << "EOF"
--- a/gcc/ubsan.c
+++ b/gcc/ubsan.c
@@ -1471,7 +1471,7 @@ ubsan_use_new_style_p (location_t loc)

   expanded_location xloc = expand_location (loc);
   if (xloc.file == NULL || strncmp (xloc.file, "\1", 2) == 0
-      || xloc.file == '\0' || xloc.file[0] == '\xff'
+      || xloc.file[0] == '\0' || xloc.file[0] == '\xff'
       || xloc.file[1] == '\xff')
     return false;
EOF

CT_TOP_DIR="$(pwd)" ct-ng defconfig
CT_ALLOW_BUILD_AS_ROOT_SURE=1 CT_TOP_DIR="$(pwd)" ct-ng build
