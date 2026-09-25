VERSION=${VERSION-5.48}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/file/$VERSION/file-$VERSION.tar.gz"\
    "https://astron.com/pub/file/file-$VERSION.tar.gz"
rm -rf file-$VERSION && tar -zxf "file-$VERSION.tar.gz"
rm -f "file-$VERSION.tar.gz"
cd file-$VERSION

mkdir build
pushd build
    ../configure\
        --disable-bzlib\
        --disable-libseccomp\
        --disable-xzlib\
        --disable-zlib
    make
popd

./configure --prefix=/usr --host=$SCUDUM_TARGET --build=$(./config.guess)
make FILE_COMPILE=$(pwd)/build/src/file && make DESTDIR=$SCUDUM install

rm -v $SCUDUM/usr/lib/libmagic.la
