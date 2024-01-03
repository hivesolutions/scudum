rget https://hg.mozilla.org/mozilla-central/raw-file/tip/security/nss/lib/ckfw/builtins/certdata.txt

rm -f usr/share/ssl/certdata.txt &&\
    cp -rp certdata.txt usr/share/ssl/certdata.txt

cert.build
