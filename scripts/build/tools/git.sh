[ "$SCUDUM_CROSS" == "0" ] && exit 0 || true

VERSION=${VERSION-2.13.3}

set -e +h

wget "https://www.kernel.org/pub/software/scm/git/git-$VERSION.tar.xz"
rm -rf git-$VERSION && tar -Jxf "git-$VERSION.tar.xz"
rm -f "git-$VERSION.tar.xz"
cd git-$VERSION

./configure --prefix=$PREFIX

make && make install
