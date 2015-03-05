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
    PYTHON_TOOLS_LIB=/tools/lib/python$PYTHON_VERSION/site-packages

    rm -rf $PYTHON_LIB/pkg_resources* && mv $PYTHON_TOOLS_LIB/pkg_resources* $PYTHON_LIB
    rm -rf $PYTHON_LIB/easy_install* && mv $PYTHON_TOOLS_LIB/easy_install* $PYTHON_LIB
    rm -rf $PYTHON_LIB/setuptools* && mv $PYTHON_TOOLS_LIB/setuptools* $PYTHON_LIB
    rm -rf $PYTHON_LIB/_markerlib* && mv $PYTHON_TOOLS_LIB/_markerlib* $PYTHON_LIB
    rm -rf $PYTHON_LIB/pip* && mv $PYTHON_TOOLS_LIB/pip* $PYTHON_LIB

    mv /tools/bin/pip{,2*} /usr/bin
    mv /tools/bin/easy_install{,2*} /usr/bin

    sed -i 's/\/tools\/bin/\/usr\/bin/g' /usr/bin/pip{,2*}
    sed -i 's/\/tools\/bin/\/usr\/bin/g' /usr/bin/easy_install{,2*}
fi
