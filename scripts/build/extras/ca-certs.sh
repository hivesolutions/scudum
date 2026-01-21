DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

if [ "$UNSAFE" == "1" ]; then
    wget --no-check-certificate https://hg-edge.mozilla.org/releases/mozilla-release/raw-file/default/security/nss/lib/ckfw/builtins/certdata.txt
else
    wget https://hg-edge.mozilla.org/releases/mozilla-release/raw-file/default/security/nss/lib/ckfw/builtins/certdata.txt
fi

echo "#CVS_ID @# $ RCSfile: certdata.txt $ $Revision:  $ $Date: $" >> certdata.txt

rm -f /usr/share/ssl/certdata.txt &&\
    mv certdata.txt /usr/share/ssl

FORCE=1 cert.build
