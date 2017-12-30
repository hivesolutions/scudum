VERSION=${VERSION-1.22.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "python" "cmake"

git clone https://github.com/rust-lang/rust.git
cd rust
git checkout $VERSION

cat > config.toml << "EOF"
[llvm]
[build]
[install]
prefix = "$PREFIX"
[rust]
channel = "stable"
[target.x86_64-unknown-linux-gnu]
[dist]
EOF
sed -i "s|\$PREFIX|$PREFIX|g" config.toml

./x.py build && ./x.py install
