include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = whatsup
VERSION = master
ARCHIVE = $(PACKAGE)-$(VERSION).tar.gz
URL     = git@github.com:chaos/$(PACKAGE).git

CFLAGS += -I$(CURDIR)/$(SRCDIR)/libltdl

CONFIGURE = ./configure --prefix=$(PREFIX) --host=$(ARCH)-linux --enable-debug

TARGET=$(SRCDIR)/src/pingd/pingd

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(PACKAGE):
	cd $(TARBALLS_LOCATION); $(GIT_TOOL) clone $(URL)

$(TARBALLS_LOCATION)/$(ARCHIVE): $(TARBALLS_LOCATION)/$(PACKAGE)
	cd $(TARBALLS_LOCATION)/$(PACKAGE); \
	$(GIT_TOOL) archive $(VERSION) | $(GZIP_TOOL) > ../$(ARCHIVE)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR) && \
	$(ARCHIVE_TOOL) -xf $(TARBALLS_LOCATION)/$(ARCHIVE); \
	$(APPLY_PATCH); \
	./autogen.sh; \
	$(CONFIGURE)

$(TARGET): $(SRCDIR)
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

