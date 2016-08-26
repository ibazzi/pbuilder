include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = tvheadend
VERSION = master
ARCHIVE = $(PACKAGE)-$(VERSION).tar.gz
URL     = git@github.com:ibazzi/$(PACKAGE).git

TARGET=$(SRCDIR)/build.linux/tvheadend

CONFIGURE=./configure --prefix=$(PREFIX) --arch=arm --disable-avahi --disable-libav \
			--disable-pie --enable-bundle --disable-ffmpeg_static --disable-hdhomerun_static \
			--disable-dbus_1 --disable-inotify --disable-imagecache

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(PACKAGE):
	cd $(TARBALLS_LOCATION); $(GIT_TOOL) clone $(URL)

$(TARBALLS_LOCATION)/$(ARCHIVE): $(TARBALLS_LOCATION)/$(PACKAGE)
	cd $(TARBALLS_LOCATION)/$(PACKAGE); \
	$(GIT_TOOL) archive $(VERSION) | $(GZIP_TOOL) > ../$(ARCHIVE)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR); \
	$(ARCHIVE_TOOL) -xf $(TARBALLS_LOCATION)/$(ARCHIVE); \
	cp -r $(TARBALLS_LOCATION)/$(PACKAGE)/.git ./; \
	$(CONFIGURE)

$(TARGET): $(SRCDIR)
	$(MAKE) -C $(SRCDIR) -j$(JOBS) install
	
.installed_$(ARCH): $(TARGET)
	touch $(TARGET)
	touch $@

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f .installed_$(ARCH)
	
distclean:
	rm -rf $(SRCDIR) .installed_$(ARCH)

