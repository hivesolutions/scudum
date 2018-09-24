VERSION=${VERSION-5.4.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "zsh"

curl -L http://install.ohmyz.sh | sh
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="pygmalion"/g' /root/.zshrc
