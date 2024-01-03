DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget https://hg.mozilla.org/mozilla-central/raw-file/tip/security/nss/lib/ckfw/builtins/certdata.txt

echo "#CVS_ID @# $ RCSfile: certdata.txt $ $Revision:  $ $Date: $" >> certdata.txt

rm -f /usr/share/ssl/certdata.txt &&\
    mv certdata.txt /usr/share/ssl

FORCE=1 cert.build
