include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = libiconv
VERSION = 1.14
SOURCE  = $(PACKAGE)-$(VERSION)
ARCHIVE = $(SOURCE).tar.gz
URL     = http://ftp.gnu.org/pub/gnu/libiconv/$(ARCHIVE)

# configuration settings
CONFIGURE = ./configure --prefix=$(PREFIX) --host=$(ARCH)-linux

TARGET=$(SRCDIR)/lib/.libs/libiconv.la

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(ARCHIVE):
	cd $(TARBALLS_LOCATION); $(RETRIEVE_TOOL) $(RETRIEVE_TOOL_FLAGS) $(URL)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR); \
	$(ARCHIVE_TOOL) $(ARCHIVE_TOOL_FLAGS) $(TARBALLS_LOCATION)/$(ARCHIVE); \
	$(APPLY_PATCH); \
	$(CONFIGURE)

$(TARGET): $(SRCDIR)
	$(MAKE) -C $(SRCDIR) -j$(JOBS)

.installed_$(ARCH): $(TARGET)
	$(MAKE) -C $(SRCDIR) install
	touch $(TARGET)
	touch $@

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f .installed_$(ARCH)
	
distclean:
	rm -rf $(SRCDIR) .installed_$(ARCH)

