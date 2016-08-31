include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = dvb-apps
SOURCE  = tip
ARCHIVE = $(SOURCE).tar.gz
URL     = https://linuxtv.org/hg/dvb-apps/archive/$(ARCHIVE)

# configuration settings
VERSION_FILE = $(DESTDIR)/usr/include/linux/dvb/version.h

TARGET=$(SRCDIR)/$(PACKAGE).all

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(ARCHIVE):
	cd $(TARBALLS_LOCATION); $(RETRIEVE_TOOL) $(RETRIEVE_TOOL_FLAGS) $(URL)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR); \
	$(ARCHIVE_TOOL) $(ARCHIVE_TOOL_FLAGS) $(TARBALLS_LOCATION)/$(ARCHIVE); \
	$(APPLY_PATCH)

$(TARGET): $(SRCDIR)
	VERSION_FILE=$(VERSION_FILE) $(MAKE) -C $(SRCDIR) -j$(JOBS)

.installed_$(ARCH): $(TARGET)
	$(MAKE) -C $(SRCDIR) install
	touch $(TARGET)
	touch $@

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f .installed_$(ARCH)
	
distclean:
	rm -rf $(SRCDIR) .installed_$(ARCH)

