VERSION=${VERSION-2.7.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "http://ftp.gnu.org/pub/gnu/nano/nano-$VERSION.tar.gz"\
    "http://www.nano-editor.org/dist/v2.2/nano-$VERSION.tar.gz"
rm -rf nano-$VERSION && tar -zxf "nano-$VERSION.tar.gz"
rm -f "nano-$VERSION.tar.gz"
cd nano-$VERSION

./configure --host=$ARCH_TARGET --prefix=/usr

make && make install

ln -svf nano /usr/bin/pico

for file in /usr/share/nano/*.nanorc; do
    sed -i 's/\\</\\b/g' $file
    sed -i 's/\\>/\\b/g' $file
done
