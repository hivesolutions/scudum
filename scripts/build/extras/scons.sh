VERSION=${VERSION-2.3.3}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "python"

if [ "$PREFIX" == "/usr" ]; then
    ARGS=""
else
    ARGS="--user"
fi

wget "http://prdownloads.sourceforge.net/scons/scons-$VERSION.tar.gz"
rm -rf scons-$VERSION && tar -zxf "scons-$VERSION.tar.gz"
rm -f "scons-$VERSION.tar.gz"
cd scons-$VERSION

python setup.py install $ARGS
