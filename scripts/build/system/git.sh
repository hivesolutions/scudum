VERSION=${VERSION-2.55.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/git/$VERSION/git-$VERSION.tar.xz"\
    "https://www.kernel.org/pub/software/scm/git/git-$VERSION.tar.xz"
rm -rf git-$VERSION && tar -Jxf "git-$VERSION.tar.xz"
rm -f "git-$VERSION.tar.xz"
cd git-$VERSION

sed -i 's/as_fn_error ()/as_fn_error ()\n{\nreturn 0\n}\nold_as_fn_error ()\n/' configure

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --with-gitconfig=/etc/gitconfig\
    --with-python=python3

# builds without the rust based parts (no rust toolchain in the root)
make NO_RUST=1 && make NO_RUST=1 install
