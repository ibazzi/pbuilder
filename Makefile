include Makefile.include

PACKAGES = \
	zlib openssl c-ares \
	opennhrp dnsmasq n2n \
	ncurses nano siproxd \
	libosip2 iproute2 \
	ipset libmnl libnftnl \
	iptables

all: $(PACKAGES)

openssl: zlib
opennhrp: c-ares
nano: ncurses
siproxd: libosip2
libmnl: kernel-headers-install
ipset: libmnl
libnftnl: libmnl
iptables: libnftnl

$(PACKAGES):
	$(MAKE) -C $@

kernel-headers-install:
	cd $(KERNEL_LOCATION); \
	$(MAKE) headers_install INSTALL_HDR_PATH=$(DESTDIR)$(PREFIX)

clear-install-dir:
	rm -rf $(DESTDIR)

clean:
	for d in $(PACKAGES); do $(MAKE) -C $$d clean; done

distclean: clear-install-dir
	for d in $(PACKAGES); do $(MAKE) -C $$d distclean; done

.PHONY: $(PACKAGES)

