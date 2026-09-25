VERSION=${VERSION-5.3}
VERSION_L=${VERSION_L-53}
PATCH_SEQ=${PATCH_SEQ-1 20}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/bash/$VERSION/bash-$VERSION.tar.gz"\
    "https://ftpmirror.gnu.org/bash/bash-$VERSION.tar.gz"
rm -rf bash-$VERSION && tar -zxf "bash-$VERSION.tar.gz"
rm -f "bash-$VERSION.tar.gz"
cd bash-$VERSION

for index in $(seq -f "%03g" $PATCH_SEQ); do
    rget "https://mirrors.hive.pt/mirrors/scudum/bash/$VERSION/bash$VERSION_L-$index"\
        "https://ftpmirror.gnu.org/bash/bash-$VERSION-patches/bash$VERSION_L-$index"
    patch -Np0 -i bash$VERSION_L-$index
done

./configure\
    --prefix=/usr\
    --build=$(sh support/config.guess)\
    --host=$SCUDUM_TARGET\
    --without-bash-malloc\
    --docdir=/usr/share/doc/bash-$VERSION

make && make DESTDIR=$SCUDUM install

ln -svf bash $SCUDUM/bin/sh
