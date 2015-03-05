DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

if [ "$PREFIX" == "/usr" ]; then
    ARGS=""
else
    ARGS="--user"
fi

rm -f get-pip.py && wget "https://bootstrap.pypa.io/get-pip.py"
python get-pip.py $ARGS

if [ "$SCUDUM_CROSS" == "1" ]; then
    PYTHON_VERSION=$(python -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";)
    PYTHON_LIB=/usr/lib/python$PYTHON_VERSION/site-packages
    export PYTHONPATH=$PYTHON_LIB
    pip install pip --exists-action=ignore --install-option="--prefix=/usr" --install-option="--install-purelib=$PYTHON_LIB" --verbose
fi
