include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE	= nano
VERSION	= 2.6.3
SOURCE	= $(PACKAGE)-$(VERSION)
ARCHIVE	= $(SOURCE).tar.gz
URL		= https://www.nano-editor.org/dist/v2.6/$(ARCHIVE)

CONFIGURE = ./configure --prefix=$(PREFIX) --host=$(ARCH)-linux CFLAGS=-I$(INCLUDEDIR) LDFLAGS=-L$(LIBDIR)

TARGET=$(SRCDIR)/src/nano

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(ARCHIVE):
	cd $(TARBALLS_LOCATION); $(RETRIEVE_TOOL) $(RETRIEVE_TOOL_FLAGS) $(URL)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR) && \
	$(ARCHIVE_TOOL) $(ARCHIVE_TOOL_FLAGS) $(TARBALLS_LOCATION)/$(ARCHIVE) && \
	$(CONFIGURE)

$(TARGET): $(SRCDIR)
	$(MAKE) -C $(SRCDIR) -j$(JOBS)

.installed_$(ARCH): $(TARGET)
	$(STRIP) $(TARGET)
	$(MAKE) -C $(SRCDIR) install
	touch $(TARGET)
	touch $@

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f .installed_$(ARCH)
	
distclean::
	rm -rf $(SRCDIR) .installed_$(ARCH)

