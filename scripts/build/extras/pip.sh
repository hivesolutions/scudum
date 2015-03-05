VERSION=${VERSION-6.0.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

wget "https://pypi.python.org/packages/source/p/pip/pip-6.0.8.tar.gz"
rm -rf pip-6.0.8 && tar -zxf "pip-6.0.8.tar.gz"
rm -f "pip-6.0.8.tar.gz"
cd pip-6.0.8

if [ "$SCUDUM_CROSS" == "1" ]; then
    rm -f get-pip.py && wget "https://bootstrap.pypa.io/get-pip.py"
    python get-pip.py $ARGS
fi

if [ "$PREFIX" == "/usr" ]; then
    if [ "$SCUDUM_CROSS" == "1" ]; then
        PYTHON_VERSION=$(python -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";)
        PYTHON_LIB=/usr/lib/python$PYTHON_VERSION/site-packages
        export PYTHONPATH=$PYTHON_LIB
        ARGS="--install-scripts=/usr/bin --install-purelib=$PYTHON_LIB"
    else
        ARGS=""
    fi
else
    ARGS="--user"
fi

python setup.py install $ARGS
