VERSION=${VERSION-1.07.1}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/bc/bc-$VERSION.tar.gz"
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

./configure --host=$ARCH_TARGET --prefix=/usr

make && make install
