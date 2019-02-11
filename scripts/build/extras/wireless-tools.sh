VERSION=${VERSION-29}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://ftp.lfs-matrix.net/pub/clfs/conglomeration/wireless_tools.$VERSION.tar.gz/wireless_tools.$VERSION.tar.gz"\
    "https://ftp.osuosl.org/pub/clfs/conglomeration/wireless_tools.$VERSION.tar.gz/wireless_tools.$VERSION.tar.gz"\
    "http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/wireless_tools.$VERSION.tar.gz"
rm -rf wireless_tools.$VERSION && tar -zxf "wireless_tools.$VERSION.tar.gz"
rm -f "wireless_tools.$VERSION.tar.gz"
cd wireless_tools.$VERSION

if [ "$SCUDUM_CROSS" == "1" ]; then
    make CC="$CC" && make PREFIX=$PREFIX INSTALL_MAN=$PREFIX/share/man install
else
    make && make PREFIX=$PREFIX INSTALL_MAN=$PREFIX/share/man install
fi
