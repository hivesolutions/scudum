DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python"

if [ "$PREFIX" == "/usr" ]; then
    ARGS=""
else
    ARGS="--user"
fi

if [ "$SCUDUM_CROSS" == "1" ]; then
    ARGS="$ARGS --target /usr/lib/python2.7/site-packages -–install-option=\"–-install-scripts=/usr/bin\" -–install-option=\"–-prefix=/usr\""
fi

rm -f get-pip.py && wget "https://bootstrap.pypa.io/get-pip.py"
python get-pip.py $ARGS
