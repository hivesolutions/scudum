VERSION=${VERSION-9.0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://download.java.net/java/GA/jdk9/$VERSION/binaries/openjdk-$VERSION_linux-x64_bin.tar.gz"
rm -rf jdk-$VERSION && tar -zxf "openjdk-$VERSION_linux-x64_bin.tar.gz"
rm -f "openjdk-$VERSION_linux-x64_bin.tar.gz"

mv jdk-$VERSION $PREFIX

ln -s $PREFIX/jdk-$VERSION/bin/java $PREFIX/bin/java
ln -s $PREFIX/jdk-$VERSION/bin/javac $PREFIX/bin/javac
