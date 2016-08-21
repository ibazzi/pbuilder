include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = n2n
VERSION = master
ARCHIVE = $(PACKAGE).tar.gz
URL     = git@github.com:ibazzi/$(PACKAGE).git

BUILDDIR  = build
ifneq ($(ARCH),x86_64)
CMAKE_TOOLCHAIN_FILE = -DCMAKE_TOOLCHAIN_FILE=../n2n_v2/cmake/CMakeToolchainFile.$(ARCH).cmake
endif
N2N_OPTIONS = -DN2N_OPTION_COMPRESSION=OFF -DN2N_OPTION_AES=OFF -DCMAKE_BUILD_TYPE=Release
CONFIGURE =  $(CMAKE_TOOL) $(N2N_OPTIONS) -DCMAKE_INSTALL_PREFIX=$(PREFIX) $(CMAKE_TOOLCHAIN_FILE) ../n2n_v2/

TARGET=$(SRCDIR)/$(BUILDDIR)/edge

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(PACKAGE):
	cd $(TARBALLS_LOCATION); $(GIT_TOOL) clone $(URL)

$(TARBALLS_LOCATION)/$(ARCHIVE): $(TARBALLS_LOCATION)/$(PACKAGE)
	cd $(TARBALLS_LOCATION)/$(PACKAGE) && \
	$(GIT_TOOL) archive $(VERSION) | $(GZIP_TOOL) > ../$(ARCHIVE)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR) && \
	$(ARCHIVE_TOOL) -xf $(TARBALLS_LOCATION)/$(ARCHIVE) && \
	mkdir -p $(BUILDDIR) && cd $(BUILDDIR) && \
	$(CONFIGURE)

$(TARGET): $(SRCDIR)
	$(MAKE) -C $(SRCDIR)/$(BUILDDIR) -j$(JOBS)
	$(STRIP) $(SRCDIR)/$(BUILDDIR)/edge
	$(STRIP) $(SRCDIR)/$(BUILDDIR)/supernode

.installed_$(ARCH): $(TARGET)
	$(MAKE) -C $(SRCDIR)/$(BUILDDIR) install
	touch $(TARGET)
	touch $@

clean:
	$(MAKE) -C $(SRCDIR)/$(BUILDDIR) clean
	rm -f .installed_$(ARCH)

distclean:
	rm -rf $(SRCDIR) .installed_$(ARCH)

