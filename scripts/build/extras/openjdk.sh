VERSION=${VERSION-9.0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://download.java.net/java/GA/jdk9/$VERSION/binaries/openjdk-${VERSION}_linux-x64_bin.tar.gz"
rm -rf jdk-$VERSION && tar -zxf "openjdk-${VERSION}_linux-x64_bin.tar.gz"
rm -f "openjdk-${VERSION}_linux-x64_bin.tar.gz"

rm -rf $PREFIX/jdk-$VERSION && mv jdk-$VERSION $PREFIX

ln -svf $PREFIX/jdk-$VERSION/bin/java $PREFIX/bin/java
ln -svf $PREFIX/jdk-$VERSION/bin/javac $PREFIX/bin/javac
ln -svf $PREFIX/jdk-$VERSION/bin/keytool $PREFIX/bin/keytool

for file in /usr/ssl/certs/*.pem; do
    openssl x509 -in $file -inform pem -out temp.der -outform der
    keytool -importcert -file temp.der -cacerts
    rm -f temp.der
done
