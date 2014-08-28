SSLDIR=/etc/ssl

set -e

rm -f certdata.txt &&\
wget --no-check-certificate https://hg.mozilla.org/releases/mozilla-release/raw-file/default/security/nss/lib/ckfw/builtins/certdata.txt &&\
make-ca.sh &&\
remove-expired-certs.sh certs

install -d ${SSLDIR}/certs &&\
cp -v certs/*.pem ${SSLDIR}/certs &&\
c_rehash &&\
install BLFS-ca-bundle*.crt ${SSLDIR}/ca-bundle.crt &&\
ln -sfv ../ca-bundle.crt ${SSLDIR}/certs/ca-certificates.crt
