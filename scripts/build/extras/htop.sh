VERSION=${VERSION-3.0.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

wget --content-disposition "https://bintray.com/htop/source/download_file?file_path=htop-$VERSION.tar.gz"
rm -rf htop-$VERSION && tar -zxf "htop-$VERSION.tar.gz"
rm -f "htop-$VERSION.tar.gz"
cd htop-$VERSION

./configure --prefix=$PREFIX
make && make install
