DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "pypy"

if [ "$PREFIX" == "/usr" ]; then
    ARGS=""
else
    ARGS="--user"
fi

rm -f get-pip.py && wget --content-disposition "https://bootstrap.pypa.io/get-pip.py"
pypy get-pip.py $ARGS

ln -svf ../lib/pypy/bin/pip $PREFIX/bin/pypy-pip
