VERSION=${VERSION-7.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "attr" "lzo" "zstd" "acl" "python3"

# installs the setuptools required by the python bindings, as
# the python3 pip bootstrap no longer includes it since 3.12
pip3 install --quiet setuptools

rget "https://mirrors.hive.pt/mirrors/scudum/btrfs-progs/$VERSION/btrfs-progs-v$VERSION.tar.xz"\
    "https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/btrfs-progs-v$VERSION.tar.xz"
rm -rf btrfs-progs-v$VERSION && tar -Jxf "btrfs-progs-v$VERSION.tar.xz"
rm -f "btrfs-progs-v$VERSION.tar.xz"
cd btrfs-progs-v$VERSION

./configure --prefix=$PREFIX --disable-documentation
make && make install
