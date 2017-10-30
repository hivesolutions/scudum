VERSION=${VERSION-9.0.1+11}
VERSION_L=${VERSION_L-9.0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --no-check-certificate -c --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$VERSION/jdk-${VERSION_L}_linux-x64_bin.tar.gz"
rm -rf jdk-$VERSION_L && tar -zxf "jdk-${VERSION_L}_linux-x64_bin.tar.gz"
rm -f "jdk-${VERSION_L}_linux-x64_bin.tar.gz"

rm -rf $PREFIX/jdk-$VERSION_L && mv jdk-$VERSION_L $PREFIX

ln -svf $PREFIX/jdk-$VERSION_L/bin/java $PREFIX/bin/java
ln -svf $PREFIX/jdk-$VERSION_L/bin/javac $PREFIX/bin/javac
ln -svf $PREFIX/jdk-$VERSION_L/bin/keytool $PREFIX/bin/keytool

for file in /usr/ssl/certs/*.pem; do
    keytool -import -noprompt -file $file -alias $file -cacerts -storepass changeit
done

mkdir -p /etc/ssl/certs/java
ln -svf $PREFIX/jdk-$VERSION_L/lib/security/cacerts /etc/ssl/certs/java/cacerts

echo "export JAVA_HOME=$PREFIX/jdk-$VERSION_L" > /etc/env/jdk.env
