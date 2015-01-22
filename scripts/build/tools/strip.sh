strip --strip-debug $PREFIX/lib/*
strip --strip-unneeded $PREFIX/{,s}bin/*

rm -rf $PREFIX/{,share}/{info,man,doc}
