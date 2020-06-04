VERSION=${VERSION-2.3.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

if [ "$PREFIX" == "/usr" ]; then
    ARGS=""
else
    ARGS="--user"
fi

wget --content-disposition "http://downloads.sourceforge.net/scons/scons-$VERSION.tar.gz?use_mirror=versaweb"
rm -rf scons-$VERSION && tar -zxf "scons-$VERSION.tar.gz"
rm -f "scons-$VERSION.tar.gz"
cd scons-$VERSION

python setup.py install $ARGS
