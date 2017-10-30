VERSION=${VERSION-4.2.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "openjdk" "unzip"

wget "https://services.gradle.org/distributions/gradle-$VERSION-bin.zip"
rm -rf gradle-$VERSION && unzip "gradle-$VERSION-bin.zip"
rm -f "gradle-$VERSION-bin.zip"

mv gradle-$VERSION $PREFIX

ln -s $PREFIX/gradle-$VERSION/bin/gradle $PREFIX/bin/gradle
