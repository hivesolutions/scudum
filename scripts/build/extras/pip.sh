VERSION=${VERSION-6.0.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

wget "https://pypi.python.org/packages/source/p/pip/pip-6.0.8.tar.gz"
rm -rf pip-6.0.8 && tar -zxf "pip-6.0.8.tar.gz"
rm -f "pip-6.0.8.tar.gz"
cd pip-6.0.8

if [ "$PREFIX" == "/usr" ]; then
    if [ "$SCUDUM_CROSS" == "1" ]; then
        PYTHON_VERSION=$(python -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";)
        ARGS="--install-scripts=/usr/bin --install-purelib=/usr/lib/python$PYTHON_VERSION/site-packages"
    else
        ARGS=""
    fi
else
    ARGS="--user"
fi

echo $ARGS

python setup.py install $ARGS
