export PREFIX=${PREFIX-/usr}
export MAKEFLAGS=${MAKEFLAGS--j $(nproc)}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

source $DIR/../base/functions.sh
