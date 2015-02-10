VERSION=${VERSION-60}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://fossies.org/linux/misc/unzip$VERSION.tar.gz"
rm -rf unzip$VERSION && tar -zxf "unzip$VERSION.tar.gz"
rm -f "unzip$VERSION.tar.gz"
cd unzip$VERSION

case $SCUDUM_ARCH in
    i?86)
        sed -i -e 's/DASM_CRC"/DASM_CRC -DNO_LCHMOD"/' unix/Makefile
        make -f unix/Makefile linux
        ;;
    *)
        sed -i -e 's/CFLAGS="-O -Wall/& -DNO_LCHMOD/' unix/Makefile
        make -f unix/Makefile linux_noasm
        ;;
esac

make prefix=$PREFIX install
