VERSION=${VERSION-3.130}
VERSION_L=${VERSION_L-3_130}
SHA256=${SHA256-beb7e6dfe6499926e52c075c27bcfbe4c957f8609c575b3860273ae2806f63eb}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

if [ "$UNSAFE" == "1" ]; then
    rgeti "https://mirrors.hive.pt/mirrors/scudum/nss/$VERSION/certdata.txt"\
        "https://hg-edge.mozilla.org/projects/nss/raw-file/NSS_${VERSION_L}_RTM/lib/ckfw/builtins/certdata.txt"
else
    rget "https://mirrors.hive.pt/mirrors/scudum/nss/$VERSION/certdata.txt"\
        "https://hg-edge.mozilla.org/projects/nss/raw-file/NSS_${VERSION_L}_RTM/lib/ckfw/builtins/certdata.txt"
fi

echo "$SHA256  certdata.txt" | sha256sum -c

echo "#CVS_ID @# \$ RCSfile: certdata.txt \$ \$Revision: $VERSION \$ \$Date: \$" >> certdata.txt

rm -f /usr/share/ssl/certdata.txt &&\
    mv certdata.txt /usr/share/ssl

FORCE=1 cert.build
