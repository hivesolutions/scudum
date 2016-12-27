prefix = /usr

install:
	mkdir -p $(prefix)/scudum && mkdir -p $(prefix)/bin
	rm -rf $(prefix)/scudum/scripts && cp -rp scripts $(prefix)/scudum
	rm -rf $(prefix)/scudum/examples && cp -rp examples $(prefix)/scudum
	rm -f $(prefix)/bin/scudum && ln -s $(prefix)/scudum/scripts/scudum $(prefix)/bin/scudum

install-system: install
	rm -rf $(prefix)/scudum/system && cp -rp system $(prefix)/scudum
	rm -f $(prefix)/bin/kernel.build && ln -s $(prefix)/scudum/system/bin/kernel.build $(prefix)/bin/kernel.build
	rm -f $(prefix)/bin/kernel.install && ln -s $(prefix)/scudum/system/bin/kernel.install $(prefix)/bin/kernel.install
	rm -rf /boot && ln -s $(prefix)/scudum/boot /boot

uninstall:
	rm -rf $(prefix)/scudum/scripts
	rm -rf $(prefix)/scudum/examples
	rm -f $(prefix)/bin/scudum
