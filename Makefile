include Makefile.include

PACKAGES = \
	zlib openssl c-ares \
	opennhrp dnsmasq n2n \
	ncurses nano siproxd \
	libosip2 iproute2 \
	ipset libmnl libnftnl \
	iptables libiconv \
	dvb-apps tvheadend pingd \

all: $(PACKAGES)

openssl: zlib
opennhrp: c-ares
nano: ncurses
siproxd: libosip2
libmnl: kernel-headers-install
ipset: libmnl
libnftnl: libmnl
iptables: libnftnl
dvb-apps: kernel-headers-install
tvheadend: openssl libiconv dvb-apps

$(PACKAGES):
	$(MAKE) -C $@

kernel-headers-install:
	cd $(KERNEL_LOCATION); \
	$(MAKE) headers_install INSTALL_HDR_PATH=$(DESTDIR)$(PREFIX)

clear-install-dir:
	rm -rf $(DESTDIR)

clean-all:
	for d in $(PACKAGES); do \
	rm -rf $$d/src.*; \
	rm -rf $$d/.installed_*; \
	done

clean:
	for d in $(PACKAGES); do $(MAKE) -C $$d clean; done

distclean: clear-install-dir
	for d in $(PACKAGES); do $(MAKE) -C $$d distclean; done

.PHONY: $(PACKAGES)

