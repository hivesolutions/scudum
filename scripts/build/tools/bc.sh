[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-1.07.1}

set -e +h

wget "http://ftp.gnu.org/gnu/bc/bc-$VERSION.tar.gz"
rm -rf bc-$VERSION && tar -zxf "bc-$VERSION.tar.gz"
rm -f "bc-$VERSION.tar.gz"
cd bc-$VERSION

./configure --prefix=$PREFIX

make && make install
