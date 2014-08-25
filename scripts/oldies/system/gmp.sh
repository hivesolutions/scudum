VERSION="5.1.1"
tar -Jxf "gmp-$VERSION.tar.xz"
cd gmp-$VERSION

./configure --prefix=/usr --enable-cxx
make
make check 2>&1 | tee gmp-check-log
awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log
make install

cd ..
rm -rf gmp-$VERSION
