include Makefile.include

PACKAGES = \
	zlib openssl c-ares \
	opennhrp dnsmasq n2n \
	ncurses nano siproxd \
	libosip2

all: $(PACKAGES)

openssl: zlib
opennhrp: c-ares
nano: ncurses
siproxd: libosip2

$(PACKAGES):
	$(MAKE) -C $@

clean:
	for d in $(PACKAGES); do $(MAKE) -C $$d clean; done
	
distclean:
	for d in $(PACKAGES); do $(MAKE) -C $$d distclean; done
	
clear-install-dir:
	rm -rf $(DESTDIR)

.PHONY: $(PACKAGES)

