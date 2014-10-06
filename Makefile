prefix = /usr

install:
	mkdir -p $(prefix)/scudum && mkdir -p $(prefix)/bin
	rm -rf $(prefix)/scudum/scripts && cp -rp scripts $(prefix)/scudum
	rm -rf $(prefix)/scudum/examples && cp -rp examples $(prefix)/scudum
	rm -f $(prefix)/bin/scudum && ln -s $(prefix)/scudum/scripts/scudum $(prefix)/bin/scudum

uninstall:
	rm -rf $(prefix)/scudum/scripts
	rm -rf $(prefix)/scudum/examples
	rm -f $(prefix)/bin/scudum
