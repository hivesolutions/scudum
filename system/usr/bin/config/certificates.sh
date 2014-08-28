SSLDIR=/etc/ssl

set -e

rm -f certdata.txt &&\
wget --no-check-certificate http://anduin.linuxfromscratch.org/sources/other/certdata.txt &&\
make-ca.sh &&\
remove-expired-certs.sh certs

install -d ${SSLDIR}/certs &&\
cp -v certs/*.pem ${SSLDIR}/certs &&\
c_rehash &&\
install ca-bundle*.crt ${SSLDIR}/ca-bundle.crt &&\
ln -sfv ../ca-bundle.crt ${SSLDIR}/certs/ca-certificates.crt

rm -r certs ca-bundle*
