include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = siproxd
VERSION = 0.8.2dev
SOURCE  = $(PACKAGE)-$(VERSION)
ARCHIVE = $(SOURCE).tar.gz
URL     = http://siproxd.tuxworld.ch/$(ARCHIVE)

CONFIGURE=./configure --prefix=$(PREFIX) --host=$(ARCH)-linux CFLAGS=-I$(INCLUDEDIR) LDFLAGS=-L$(LIBDIR)

TARGET=$(SRCDIR)/src/siproxd

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

