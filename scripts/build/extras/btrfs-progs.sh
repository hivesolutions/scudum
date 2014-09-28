VERSION=${VERSION-3.16}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "attr" "lzo" "acl" "asciidoc" "xmlto"

wget "https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/btrfs-progs-v$VERSION.tar.gz"
rm -rf btrfs-progs-v$VERSION && tar -zxf "btrfs-progs-v$VERSION.tar.gz"
rm -f "btrfs-progs-v$VERSION.tar.gz"
cd btrfs-progs-v$VERSION

make && make install prefix=$PREFIX
