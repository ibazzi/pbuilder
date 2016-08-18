include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE	= libosip2
VERSION	= 4.1.0
SOURCE	= $(PACKAGE)-$(VERSION)
ARCHIVE	= $(SOURCE).tar.gz
URL		= http://ftp.gnu.org/gnu/osip/$(ARCHIVE)

PREFIX := $(DESTDIR)$(PREFIX)
DESTDIR=

CONFIGURE= ./configure --prefix=$(PREFIX) --host=$(ARCH)-linux --enable-shared

TARGET=$(SRCDIR)/src/osipparser2/.libs/libosipparser2.a

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(ARCHIVE):
	cd $(TARBALLS_LOCATION); $(RETRIEVE_TOOL) $(RETRIEVE_TOOL_FLAGS) $(URL)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR) && \
	$(ARCHIVE_TOOL) $(ARCHIVE_TOOL_FLAGS) $(TARBALLS_LOCATION)/$(ARCHIVE) && \
	$(CONFIGURE)

$(TARGET): $(SRCDIR) $(DEPS)
	$(MAKE) -C $(SRCDIR) -j$(JOBS)

.installed_$(ARCH): $(TARGET)
	$(MAKE) -C $(SRCDIR) install
	touch $(TARGET)
	touch $@

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f .installed_$(ARCH)
	
distclean::
	rm -rf $(SRCDIR) .installed_$(ARCH)

