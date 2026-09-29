#!/bin/sh
# Begin make-ca.sh
# Script to populate OpenSSL's CApath from a bundle of PEM formatted CAs
#
# The file certdata.txt must exist in the local directory
# Version number is obtained from the version of the data.
#
# Authors: DJ Lucas
#          Bruce Dubbs
#
# Version 20120211

certdata="certdata.txt"

if [ ! -r $certdata ]; then
  echo "$certdata must be in the local directory"
  exit 1
fi

REVISION=$(grep CVS_ID $certdata | cut -f4 -d'$')

if [ -z "${REVISION}" ]; then
  echo "$certfile has no 'Revision' in CVS_ID"
  exit 1
fi

VERSION=$(echo $REVISION | cut -f2 -d" ")

TEMPDIR=$(mktemp -d)
TODAY=$(date -u +%Y%m%d)
TRUSTATTRIBUTES="CKA_TRUST_SERVER_AUTH"
BUNDLE="ca-bundle-${VERSION}.crt"
CONVERTSCRIPT="/usr/bin/make-cert.pl"
SSLDIR="/etc/ssl"

mkdir "${TEMPDIR}/certs"

# Get a list of staring lines for each cert
CERTBEGINLIST=$(grep -n "^# Certificate" "${certdata}" | cut -d ":" -f1)

# Get a list of ending lines for each cert
CERTENDLIST=`grep -n "^CKA_TRUST_STEP_UP_APPROVED" "${certdata}" | cut -d ":" -f 1`

# Start a loop
for certbegin in ${CERTBEGINLIST}; do
  for certend in ${CERTENDLIST}; do
    if test "${certend}" -gt "${certbegin}"; then
      break
    fi
  done

  # Dump to a temp file with the name of the file as the beginning line number
  sed -n "${certbegin},${certend}p" "${certdata}" > "${TEMPDIR}/certs/${certbegin}.tmp"
done

unset CERTBEGINLIST CERTDATA CERTENDLIST certebegin certend

mkdir -p certs
rm -f certs/*      # Make sure the directory is clean

for tempfile in ${TEMPDIR}/certs/*.tmp; do
  # Make sure that the cert is trusted for server authentication and
  # that its server distrust after date (if any) has not been reached
  distrust=$(sed -n "/^CKA_NSS_SERVER_DISTRUST_AFTER MULTILINE_OCTAL/,/^END/p" "${tempfile}" | \
    sed "1d;\$d" | tr -d "\n")
  if test -n "${distrust}"; then
    distrust="20$(printf "${distrust}" | cut -c 1-6)"
  fi

  grep "CKA_TRUST_SERVER_AUTH" "${tempfile}" | \
    grep "CKT_NSS_TRUSTED_DELEGATOR" > /dev/null

  if test "${?}" != "0" || test "${distrust:-99999999}" -lt "${TODAY}"; then
    # Throw a meaningful error and remove the file
    cp "${tempfile}" tempfile.cer
    perl ${CONVERTSCRIPT} > tempfile.crt
    keyhash=$(openssl x509 -noout -in tempfile.crt -hash)
    echo "Certificate ${keyhash} is not trusted!  Removing..."
    rm -f tempfile.cer tempfile.crt "${tempfile}"
    continue
  fi

  # If execution made it to here in the loop, the temp cert is trusted
  # Find the cert data and generate a cert file for it

  cp "${tempfile}" tempfile.cer
  perl ${CONVERTSCRIPT} > tempfile.crt
  keyhash=$(openssl x509 -noout -in tempfile.crt -hash)

  # Make sure that the cert is not expired...
  if ! openssl x509 -noout -in tempfile.crt -checkend 0 > /dev/null; then
    echo "Certificate ${keyhash} is expired!  Removing..."
    rm -f tempfile.cer tempfile.crt "${tempfile}"
    continue
  fi

  # Name the file by the fingerprint, as different certs may share the
  # subject hash, openssl rehash creates the hash links (.0, .1, ...)
  keyfp=$(openssl x509 -noout -in tempfile.crt -fingerprint -sha256 | cut -d "=" -f 2 | tr -d ":")
  mv tempfile.crt "certs/${keyhash}-${keyfp}.pem"
  rm -f tempfile.cer "${tempfile}"
  echo "Created ${keyhash}-${keyfp}.pem"
done

# Remove blacklisted files
# MD5 Collision Proof of Concept CA
if ls certs/8f111d69-*.pem > /dev/null 2>&1; then
  echo "Certificate 8f111d69 is not trusted!  Removing..."
  rm -f certs/8f111d69-*.pem
fi

# Finally, generate the bundle and clean up.
cat certs/*.pem >  ${BUNDLE}
rm -r "${TEMPDIR}"
