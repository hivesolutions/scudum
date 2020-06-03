VERSION=${VERSION-4.2.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "openjdk" "unzip"

wget --content-disposition "https://services.gradle.org/distributions/gradle-$VERSION-bin.zip"
rm -rf gradle-$VERSION && unzip "gradle-$VERSION-bin.zip"
rm -f "gradle-$VERSION-bin.zip"

rm -rf $PREFIX/gradle-$VERSION && mv gradle-$VERSION $PREFIX

ln -svf $PREFIX/gradle-$VERSION/bin/gradle $PREFIX/bin/gradle
