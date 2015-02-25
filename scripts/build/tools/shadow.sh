VERSION=${VERSION-4.2.1}
EXTENSION=${EXTENSION-tar.xz}

set -e +h

wget "http://pkg-shadow.alioth.debian.org/releases/shadow-$VERSION.$EXTENSION"
rm -rf shadow-$VERSION && tar -xf "shadow-$VERSION.$EXTENSION"
rm -f "shadow-$VERSION.$EXTENSION"
cd shadow-$VERSION

ac_cv_func_setpgrp_void=yes ./configure --prefix=$TOOLS

make && make install
