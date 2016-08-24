include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = iproute2
VERSION = 4.7.0
SOURCE  = $(PACKAGE)-$(VERSION)
ARCHIVE = $(SOURCE).tar.gz
URL     = https://www.kernel.org/pub/linux/utils/net/iproute2/$(ARCHIVE)

ifneq ($(ARCH),x86_64)
KERNEL_INCLUDE=$(KERNEL_LOCATION)/include
endif

CONFIGURE=./configure $(KERNEL_INCLUDE)

TARGET=$(SRCDIR)/ip/ip

define patch_src
cd $(SRCDIR) && \
for file in $(PATCHES) ; do \
	(echo $$file) \
done;
endef
all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(ARCHIVE):
	cd $(TARBALLS_LOCATION); $(RETRIEVE_TOOL) $(RETRIEVE_TOOL_FLAGS) $(URL)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR); \
	$(ARCHIVE_TOOL) $(ARCHIVE_TOOL_FLAGS) $(TARBALLS_LOCATION)/$(ARCHIVE); \
	for file in `ls ../patches/*.patch`; do \
	(patch -p0 < $$file) \
	done; \
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

