DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget https://hg.mozilla.org/mozilla-central/raw-file/tip/security/nss/lib/ckfw/builtins/certdata.txt

rm -f usr/share/ssl/certdata.txt &&\
    cp -rp certdata.txt usr/share/ssl/certdata.txt

cert.build
