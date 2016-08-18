include ../Makefile.include
DEPS= ../Makefile.include Makefile

PACKAGE = openssl
VERSION = 1.0.2h
SOURCE  = $(PACKAGE)-$(VERSION)
ARCHIVE = $(SOURCE).tar.gz
URL     = https://www.openssl.org/source/$(ARCHIVE)

ifeq ($(ARCH),arm)
export OPENSSL_TARGET := linux-armv4
export OPENSSL_MAKEFLAGS := AES_ASM_OBJ="aes_core.o aes-armv4.o aes_cbc.o bsaes-armv7.o"
export OPENSSL_CMAKEFLAGS := -DASMAES512 -ffunction-sections -fdata-sections -Wl,--gc-sections
endif
ifeq ($(ARCH),mips)
export OPENSSL_TARGET := linux-mips32
export OPENSSL_MAKEFLAGS := AES_ASM_OBJ="aes_core.o aes_cbc.o aes-mips.o"
export OPENSSL_CMAKEFLAGS := -DASMAES512 -ffunction-sections -fdata-sections -Wl,--gc-sections -DOPENSSL_SMALL_FOOTPRINT
endif
ifeq ($(ARCH),mipsel)
export OPENSSL_TARGET := linux-mips32
export OPENSSL_CMAKEFLAGS := -ffunction-sections -fdata-sections -Wl,--gc-sections -DOPENSSL_SMALL_FOOTPRINT
endif
CC = gcc

CONFIGURE = ./Configure $(OPENSSL_TARGET) --prefix=$(DESTDIR)$(PREFIX) --openssldir=$(DESTDIR)/etc/ssl \
			-O3 -fPIC $(OPENSSL_CMAKEFLAGS) -I$(INCLUDEDIR) -L$(LIBDIR) \
			-DNDEBUG -ldl no-rc5 no-idea no-md2 no-mdc2 \
			no-sha0 no-smime no-rmd160 no-aes192 no-camellia no-ripemd no-ans1 no-krb5 \
			no-err no-hw threads no-ssl2 no-ssl3 zlib-dynamic no-ec2m shared

TARGET=$(SRCDIR)/libcrypto.a

all: .installed_$(ARCH)

$(TARBALLS_LOCATION)/$(ARCHIVE):
	cd $(TARBALLS_LOCATION); $(RETRIEVE_TOOL) $(RETRIEVE_TOOL_FLAGS) $(URL)

$(SRCDIR): $(TARBALLS_LOCATION)/$(ARCHIVE) $(DEPS)
	rm -rf $(SRCDIR); mkdir -p $(SRCDIR)
	cd $(SRCDIR) && \
	$(ARCHIVE_TOOL) $(ARCHIVE_TOOL_FLAGS) $(TARBALLS_LOCATION)/$(ARCHIVE) && \
	$(CONFIGURE)

$(TARGET): $(SRCDIR)
	$(MAKE) -C $(SRCDIR) -j$(JOBS) depend
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

