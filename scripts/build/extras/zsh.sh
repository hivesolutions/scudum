VERSION=${VERSION-5.4.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://downloads.sourceforge.net/zsh/zsh-$VERSION.tar.gz"\
    "http://www.zsh.org/pub/old/zsh-$VERSION.tar.gz"
rm -rf zsh-$VERSION && tar -zxf "zsh-$VERSION.tar.gz"
rm -f "zsh-$VERSION.tar.gz"
cd zsh-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install

cat > /root/.zshrc  << "EOF"
autoload -U compinit promptinit
compinit
promptinit
prompt walters
EOF

ln -svf /bin/zsh $PREFIX/bin/zsh

echo "/bin/zsh" >> /etc/shells
