[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-1.07.1}

set -e +h

wget "http://ftp.gnu.org/gnu/bc/bc-$VERSION.tar.gz"
rm -rf bc-$VERSION && tar -zxf "bc-$VERSION.tar.gz"
rm -f "bc-$VERSION.tar.gz"
cd bc-$VERSION

cat > bc/fix-libmath_h << "EOF"
#! /bin/bash
sed -e '1   s/^/{"/'\
    -e 's/$/",/'\
    -e '2,$ s/^/"/'\
    -e '$ d'\
    -i libmath.h

sed -e '$ s/$/0}/' -i libmath.h
EOF

./configure --prefix=$PREFIX

make && make install
