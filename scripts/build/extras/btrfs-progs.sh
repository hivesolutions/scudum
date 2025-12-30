VERSION=${VERSION-5.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "attr" "lzo" "zstd" "acl" "asciidoc" "xmlto" "python3"

wget --content-disposition "https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/btrfs-progs-v$VERSION.tar.gz"
rm -rf btrfs-progs-v$VERSION && tar -zxf "btrfs-progs-v$VERSION.tar.gz"
rm -f "btrfs-progs-v$VERSION.tar.gz"
cd btrfs-progs-v$VERSION

./configure --prefix=$PREFIX --disable-documentation
make && make install
