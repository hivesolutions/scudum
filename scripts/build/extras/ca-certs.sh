DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget http://hg.mozilla.org/mozilla-central/raw-file/tip/security/nss/lib/ckfw/builtins/certdata.txt

rm -f usr/share/ssl/certdata.txt &&\
    mv certdata.txt /usr/share/ssl

cert.build
