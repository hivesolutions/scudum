install:
	mkdir -p /usr/scudum
	rm -rf /usr/scudum/scripts && cp -rp scripts /usr/scudum
	rm -f /usr/bin/scudum && ln -s /usr/scudum/scripts/scudum /usr/bin/scudum

uninstall:
	rm -rf /usr/scudum/scripts
	rm -f /usr/bin/scudum
