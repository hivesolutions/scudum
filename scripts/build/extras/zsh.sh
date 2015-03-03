VERSION=${VERSION-5.0.6}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://downloads.sourceforge.net/zsh/zsh-$VERSION.tar.bz2"\
    "http://www.zsh.org/pub/old/zsh-$VERSION.tar.bz2"
rm -rf zsh-$VERSION && tar -jxf "zsh-$VERSION.tar.bz2"
rm -f "zsh-$VERSION.tar.bz2"
cd zsh-$VERSION

./configure --prefix=$PREFIX
make && make install

cat > /root/.zshrc  << "EOF"
autoload -U compinit promptinit
compinit
promptinit
prompt walters
EOF
