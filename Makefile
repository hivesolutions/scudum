prefix = /usr

install:
	mkdir -p $prefix/scudum
	rm -rf $prefix/scudum/scripts && cp -rp scripts $prefix/scudum
	rm -f $prefix/bin/scudum && ln -s $prefix/scudum/scripts/scudum $prefix/bin/scudum

uninstall:
	rm -rf $prefix/scudum/scripts
	rm -f $prefix/bin/scudum
