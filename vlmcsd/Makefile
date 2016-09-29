include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = vlmcsd
VERSION = master
ARCHIVE = $(PACKAGE)-$(VERSION).tar.gz
URL     = git@github.com:Wind4/$(PACKAGE).git

TARGET=$(SRCDIR)/vlmcsd

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(PACKAGE):
	cd $(TARBALLS_LOCATION); $(GIT_TOOL) clone $(URL)

$(TARBALLS_LOCATION)/$(ARCHIVE): $(TARBALLS_LOCATION)/$(PACKAGE)
	cd $(TARBALLS_LOCATION)/$(PACKAGE) && \
	$(GIT_TOOL) archive $(VERSION) | $(GZIP_TOOL) > ../$(ARCHIVE)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR) && \
	$(ARCHIVE_TOOL) -xf $(TARBALLS_LOCATION)/$(ARCHIVE)

$(TARGET): $(SRCDIR)
	$(MAKE) -C $(SRCDIR) -j$(JOBS)
	
.installed_$(ARCH): $(TARGET)
	install -d $(DESTDIR)/usr/sbin
	install $(TARGET) $(DESTDIR)/usr/sbin
	touch $(TARGET)
	touch $@

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f .installed_$(ARCH)
	
distclean:
	rm -rf $(SRCDIR) .installed_$(ARCH)

