include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = ZeroTierOne
VERSION = master
ARCHIVE = $(PACKAGE)-$(VERSION).tar.gz
URL     = https://github.com/zerotier/$(PACKAGE).git

TARGET=$(SRCDIR)/zerotier-one

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(PACKAGE):
	cd $(TARBALLS_LOCATION); $(GIT_TOOL) clone $(URL)

$(TARBALLS_LOCATION)/$(ARCHIVE): $(TARBALLS_LOCATION)/$(PACKAGE)
	cd $(TARBALLS_LOCATION)/$(PACKAGE) && \
	$(GIT_TOOL) archive $(VERSION) | $(GZIP_TOOL) > ../$(ARCHIVE)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR) && \
	cp -r $(TARBALLS_LOCATION)/$(PACKAGE)/.git ./; \
	$(ARCHIVE_TOOL) -xf $(TARBALLS_LOCATION)/$(ARCHIVE); \
	$(APPLY_PATCH)

$(TARGET): $(SRCDIR)
	DEFS="-DNEED_PRINTF" $(MAKE) -C $(SRCDIR) -j$(JOBS)
	$(STRIP) $(TARGET)
	
.installed_$(ARCH): $(TARGET)
	$(MAKE) -C $(SRCDIR) install
	touch $(TARGET)
	touch $@

deb-package: $(SRCDIR)
	cd $(SRCDIR) && \
	dpkg-buildpackage -d -a$(ARCH)

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f .installed_$(ARCH)
	
distclean:
	rm -rf $(SRCDIR) .installed_$(ARCH)

