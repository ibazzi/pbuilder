include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = iptables
VERSION = 1.6.0
SOURCE  = $(PACKAGE)-$(VERSION)
ARCHIVE = $(SOURCE).tar.bz2
URL     = http://www.netfilter.org/projects/iptables/files/$(ARCHIVE)

PREFIX:=$(DESTDIR)/usr
DESTDIR:=

CONFIGURE=./configure --prefix=$(PREFIX) --host=$(ARCH)-linux \
			--enable-static --disable-nftables \
			LDFLAGS="$(LDFLAGS) -lmnl -lnftnl"

TARGET=$(SRCDIR)/iptables/.libs/xtables-multi

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(ARCHIVE):
	cd $(TARBALLS_LOCATION); $(RETRIEVE_TOOL) $(RETRIEVE_TOOL_FLAGS) $(URL)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR); \
	$(ARCHIVE_TOOL) $(ARCHIVE_TOOL_FLAGS) $(TARBALLS_LOCATION)/$(ARCHIVE); \
	$(APPLY_PATCH); \
	$(CONFIGURE)

$(TARGET): $(SRCDIR) $(DEPS)
	$(MAKE) -C $(SRCDIR) -j$(JOBS)
	$(STRIP) $(TARGET)

.installed_$(ARCH): $(TARGET)
	$(MAKE) -C $(SRCDIR) install
	touch $(TARGET)
	touch $@

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f .installed_$(ARCH)
	
distclean:
	rm -rf $(SRCDIR) .installed_$(ARCH)

