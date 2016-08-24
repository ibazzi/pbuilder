include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = libnftnl
VERSION = 1.0.6
SOURCE  = $(PACKAGE)-$(VERSION)
ARCHIVE = $(SOURCE).tar.bz2
URL     = http://www.netfilter.org/projects/libnftnl/files/$(ARCHIVE)

PREFIX:=$(DESTDIR)/usr
DESTDIR:=

CONFIGURE=./configure --prefix=$(PREFIX) --host=$(ARCH)-linux \
			LIBMNL_CFLAGS=-I$(INCLUDEDIR) LIBMNL_LIBS="-L$(LIBDIR) -lmnl"

TARGET=$(SRCDIR)/src/.libs/libnftnl.so.4.1.0

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
	
distclean:
	rm -rf $(SRCDIR) .installed_$(ARCH)

