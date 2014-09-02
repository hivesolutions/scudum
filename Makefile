all:
	rm -rf /usr/scudum && cp -rp scripts /usr/scudum
	rm -f /usr/bin/scudum && ln -s /usr/scudum/scudum /usr/bin/scudum
