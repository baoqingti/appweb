#
#   appweb-freebsd-static.mk -- Makefile to build Embedthis Appweb for freebsd
#

NAME                  := appweb
VERSION               := 4.6.0
PROFILE               ?= static
ARCH                  ?= $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
CC_ARCH               ?= $(shell echo $(ARCH) | sed 's/x86/i686/;s/x64/x86_64/')
OS                    ?= freebsd
CC                    ?= gcc
CONFIG                ?= $(OS)-$(ARCH)-$(PROFILE)
LBIN                  ?= $(CONFIG)/bin
PATH                  := $(LBIN):$(PATH)

ME_COM_CGI            ?= 1
ME_COM_DIR            ?= 1
ME_COM_EJS            ?= 0
ME_COM_ESP            ?= 1
ME_COM_EST            ?= 1
ME_COM_HTTP           ?= 1
ME_COM_MATRIXSSL      ?= 0
ME_COM_MDB            ?= 1
ME_COM_NANOSSL        ?= 0
ME_COM_OPENSSL        ?= 0
ME_COM_PCRE           ?= 1
ME_COM_PHP            ?= 0
ME_COM_SQLITE         ?= 0
ME_COM_SSL            ?= 1
ME_COM_VXWORKS        ?= 0
ME_COM_WINSDK         ?= 1
ME_COM_ZLIB           ?= 0

ifeq ($(ME_COM_EST),1)
    ME_COM_SSL := 1
endif
ifeq ($(ME_COM_MATRIXSSL),1)
    ME_COM_SSL := 1
endif
ifeq ($(ME_COM_NANOSSL),1)
    ME_COM_SSL := 1
endif
ifeq ($(ME_COM_OPENSSL),1)
    ME_COM_SSL := 1
endif
ifeq ($(ME_COM_EJS),1)
    ME_COM_ZLIB := 1
endif
ifeq ($(ME_COM_ESP),1)
    ME_COM_MDB := 1
endif

ME_COM_CGI_PATH       ?= src/modules/cgiHandler.c
ME_COM_COMPILER_PATH  ?= gcc
ME_COM_DIR_PATH       ?= src/dirHandler.c
ME_COM_LIB_PATH       ?= ar
ME_COM_MATRIXSSL_PATH ?= /usr/src/matrixssl
ME_COM_NANOSSL_PATH   ?= /usr/src/nanossl
ME_COM_OPENSSL_PATH   ?= /usr/src/openssl
ME_COM_PHP_PATH       ?= /usr/src/php

CFLAGS                += -g -w
DFLAGS                +=  $(patsubst %,-D%,$(filter ME_%,$(MAKEFLAGS))) -DME_COM_CGI=$(ME_COM_CGI) -DME_COM_DIR=$(ME_COM_DIR) -DME_COM_EJS=$(ME_COM_EJS) -DME_COM_ESP=$(ME_COM_ESP) -DME_COM_EST=$(ME_COM_EST) -DME_COM_HTTP=$(ME_COM_HTTP) -DME_COM_MATRIXSSL=$(ME_COM_MATRIXSSL) -DME_COM_MDB=$(ME_COM_MDB) -DME_COM_NANOSSL=$(ME_COM_NANOSSL) -DME_COM_OPENSSL=$(ME_COM_OPENSSL) -DME_COM_PCRE=$(ME_COM_PCRE) -DME_COM_PHP=$(ME_COM_PHP) -DME_COM_SQLITE=$(ME_COM_SQLITE) -DME_COM_SSL=$(ME_COM_SSL) -DME_COM_VXWORKS=$(ME_COM_VXWORKS) -DME_COM_WINSDK=$(ME_COM_WINSDK) -DME_COM_ZLIB=$(ME_COM_ZLIB) 
IFLAGS                += "-I$(CONFIG)/inc"
LDFLAGS               += 
LIBPATHS              += -L$(CONFIG)/bin
LIBS                  += -ldl -lpthread -lm

DEBUG                 ?= debug
CFLAGS-debug          ?= -g
DFLAGS-debug          ?= -DME_DEBUG
LDFLAGS-debug         ?= -g
DFLAGS-release        ?= 
CFLAGS-release        ?= -O2
LDFLAGS-release       ?= 
CFLAGS                += $(CFLAGS-$(DEBUG))
DFLAGS                += $(DFLAGS-$(DEBUG))
LDFLAGS               += $(LDFLAGS-$(DEBUG))

ME_ROOT_PREFIX        ?= 
ME_BASE_PREFIX        ?= $(ME_ROOT_PREFIX)/usr/local
ME_DATA_PREFIX        ?= $(ME_ROOT_PREFIX)/
ME_STATE_PREFIX       ?= $(ME_ROOT_PREFIX)/var
ME_APP_PREFIX         ?= $(ME_BASE_PREFIX)/lib/$(NAME)
ME_VAPP_PREFIX        ?= $(ME_APP_PREFIX)/$(VERSION)
ME_BIN_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/bin
ME_INC_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/include
ME_LIB_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/lib
ME_MAN_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/share/man
ME_SBIN_PREFIX        ?= $(ME_ROOT_PREFIX)/usr/local/sbin
ME_ETC_PREFIX         ?= $(ME_ROOT_PREFIX)/etc/$(NAME)
ME_WEB_PREFIX         ?= $(ME_ROOT_PREFIX)/var/www/$(NAME)-default
ME_LOG_PREFIX         ?= $(ME_ROOT_PREFIX)/var/log/$(NAME)
ME_SPOOL_PREFIX       ?= $(ME_ROOT_PREFIX)/var/spool/$(NAME)
ME_CACHE_PREFIX       ?= $(ME_ROOT_PREFIX)/var/spool/$(NAME)/cache
ME_SRC_PREFIX         ?= $(ME_ROOT_PREFIX)$(NAME)-$(VERSION)


TARGETS               += $(CONFIG)/bin/appweb
TARGETS               += $(CONFIG)/bin/authpass
ifeq ($(ME_COM_CGI),1)
    TARGETS           += $(CONFIG)/bin/cgiProgram
endif
ifeq ($(ME_COM_EJS),1)
    TARGETS           += $(CONFIG)/bin/ejs.mod
endif
ifeq ($(ME_COM_EJS),1)
    TARGETS           += $(CONFIG)/bin/ejs
endif
ifeq ($(ME_COM_ESP),1)
    TARGETS           += $(CONFIG)/esp
endif
ifeq ($(ME_COM_ESP),1)
    TARGETS           += $(CONFIG)/bin/esp.conf
endif
ifeq ($(ME_COM_ESP),1)
    TARGETS           += $(CONFIG)/bin/esp
endif
TARGETS               += $(CONFIG)/bin/ca.crt
ifeq ($(ME_COM_HTTP),1)
    TARGETS           += $(CONFIG)/bin/http
endif
ifeq ($(ME_COM_SQLITE),1)
    TARGETS           += $(CONFIG)/bin/libsql.a
endif
TARGETS               += $(CONFIG)/bin/appman
TARGETS               += src/server/cache
ifeq ($(ME_COM_SQLITE),1)
    TARGETS           += $(CONFIG)/bin/sqlite
endif
ifeq ($(ME_COM_CGI),1)
    TARGETS           += test/web/auth/basic/basic.cgi
endif
ifeq ($(ME_COM_CGI),1)
    TARGETS           += test/web/caching/cache.cgi
endif
ifeq ($(ME_COM_CGI),1)
    TARGETS           += test/cgi-bin/cgiProgram
endif
ifeq ($(ME_COM_CGI),1)
    TARGETS           += test/cgi-bin/testScript
endif

unexport CDPATH

ifndef SHOW
.SILENT:
endif

all build compile: prep $(TARGETS)

.PHONY: prep

prep:
	@echo "      [Info] Use "make SHOW=1" to trace executed commands."
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(ME_APP_PREFIX)" = "" ] ; then echo WARNING: ME_APP_PREFIX not set ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/osdep.h ] && cp src/paks/osdep/osdep.h $(CONFIG)/inc/osdep.h ; true
	@if ! diff $(CONFIG)/inc/osdep.h src/paks/osdep/osdep.h >/dev/null ; then\
		cp src/paks/osdep/osdep.h $(CONFIG)/inc/osdep.h  ; \
	fi; true
	@[ ! -f $(CONFIG)/inc/me.h ] && cp projects/appweb-freebsd-static-me.h $(CONFIG)/inc/me.h ; true
	@if ! diff $(CONFIG)/inc/me.h projects/appweb-freebsd-static-me.h >/dev/null ; then\
		cp projects/appweb-freebsd-static-me.h $(CONFIG)/inc/me.h  ; \
	fi; true
	@if [ -f "$(CONFIG)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != " ` cat $(CONFIG)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build: "`cat $(CONFIG)/.makeflags`"" ; \
		fi ; \
	fi
	@echo $(MAKEFLAGS) >$(CONFIG)/.makeflags

clean:
	rm -f "$(CONFIG)/obj/appweb.o"
	rm -f "$(CONFIG)/obj/authpass.o"
	rm -f "$(CONFIG)/obj/cgiHandler.o"
	rm -f "$(CONFIG)/obj/cgiProgram.o"
	rm -f "$(CONFIG)/obj/config.o"
	rm -f "$(CONFIG)/obj/convenience.o"
	rm -f "$(CONFIG)/obj/dirHandler.o"
	rm -f "$(CONFIG)/obj/edi.o"
	rm -f "$(CONFIG)/obj/ejs.o"
	rm -f "$(CONFIG)/obj/ejsHandler.o"
	rm -f "$(CONFIG)/obj/ejsLib.o"
	rm -f "$(CONFIG)/obj/ejsc.o"
	rm -f "$(CONFIG)/obj/esp.o"
	rm -f "$(CONFIG)/obj/espAbbrev.o"
	rm -f "$(CONFIG)/obj/espDeprecated.o"
	rm -f "$(CONFIG)/obj/espFramework.o"
	rm -f "$(CONFIG)/obj/espHandler.o"
	rm -f "$(CONFIG)/obj/espHtml.o"
	rm -f "$(CONFIG)/obj/espTemplate.o"
	rm -f "$(CONFIG)/obj/estLib.o"
	rm -f "$(CONFIG)/obj/fileHandler.o"
	rm -f "$(CONFIG)/obj/http.o"
	rm -f "$(CONFIG)/obj/httpLib.o"
	rm -f "$(CONFIG)/obj/log.o"
	rm -f "$(CONFIG)/obj/makerom.o"
	rm -f "$(CONFIG)/obj/manager.o"
	rm -f "$(CONFIG)/obj/mdb.o"
	rm -f "$(CONFIG)/obj/mprLib.o"
	rm -f "$(CONFIG)/obj/mprSsl.o"
	rm -f "$(CONFIG)/obj/pcre.o"
	rm -f "$(CONFIG)/obj/phpHandler.o"
	rm -f "$(CONFIG)/obj/sdb.o"
	rm -f "$(CONFIG)/obj/server.o"
	rm -f "$(CONFIG)/obj/slink.o"
	rm -f "$(CONFIG)/obj/sqlite.o"
	rm -f "$(CONFIG)/obj/sqlite3.o"
	rm -f "$(CONFIG)/obj/sslModule.o"
	rm -f "$(CONFIG)/obj/testAppweb.o"
	rm -f "$(CONFIG)/obj/testHttp.o"
	rm -f "$(CONFIG)/obj/zlib.o"
	rm -f "$(CONFIG)/bin/appweb"
	rm -f "$(CONFIG)/bin/authpass"
	rm -f "$(CONFIG)/bin/cgiProgram"
	rm -f "$(CONFIG)/bin/ejsc"
	rm -f "$(CONFIG)/bin/ejs"
	rm -f "$(CONFIG)/bin/esp.conf"
	rm -f "$(CONFIG)/bin/esp"
	rm -f "$(CONFIG)/bin/ca.crt"
	rm -f "$(CONFIG)/bin/http"
	rm -f "$(CONFIG)/bin/libappweb.a"
	rm -f "$(CONFIG)/bin/libejs.a"
	rm -f "$(CONFIG)/bin/libest.a"
	rm -f "$(CONFIG)/bin/libhttp.a"
	rm -f "$(CONFIG)/bin/libmod_cgi.a"
	rm -f "$(CONFIG)/bin/libmod_ejs.a"
	rm -f "$(CONFIG)/bin/libmod_esp.a"
	rm -f "$(CONFIG)/bin/libmod_php.a"
	rm -f "$(CONFIG)/bin/libmod_ssl.a"
	rm -f "$(CONFIG)/bin/libmpr.a"
	rm -f "$(CONFIG)/bin/libmprssl.a"
	rm -f "$(CONFIG)/bin/libpcre.a"
	rm -f "$(CONFIG)/bin/libslink.a"
	rm -f "$(CONFIG)/bin/libsql.a"
	rm -f "$(CONFIG)/bin/libzlib.a"
	rm -f "$(CONFIG)/bin/makerom"
	rm -f "$(CONFIG)/bin/appman"
	rm -f "$(CONFIG)/bin/sqlite"
	rm -f "$(CONFIG)/bin/testAppweb"

clobber: clean
	rm -fr ./$(CONFIG)


#
#   mpr.h
#
$(CONFIG)/inc/mpr.h: $(DEPS_1)
	@echo '      [Copy] $(CONFIG)/inc/mpr.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/mpr/mpr.h $(CONFIG)/inc/mpr.h

#
#   me.h
#
$(CONFIG)/inc/me.h: $(DEPS_2)
	@echo '      [Copy] $(CONFIG)/inc/me.h'

#
#   osdep.h
#
$(CONFIG)/inc/osdep.h: $(DEPS_3)
	@echo '      [Copy] $(CONFIG)/inc/osdep.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/osdep/osdep.h $(CONFIG)/inc/osdep.h

#
#   mprLib.o
#
DEPS_4 += $(CONFIG)/inc/me.h
DEPS_4 += $(CONFIG)/inc/mpr.h
DEPS_4 += $(CONFIG)/inc/osdep.h

$(CONFIG)/obj/mprLib.o: \
    src/paks/mpr/mprLib.c $(DEPS_4)
	@echo '   [Compile] $(CONFIG)/obj/mprLib.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/mprLib.o $(LDFLAGS) $(IFLAGS) src/paks/mpr/mprLib.c

#
#   libmpr
#
DEPS_5 += $(CONFIG)/inc/mpr.h
DEPS_5 += $(CONFIG)/inc/me.h
DEPS_5 += $(CONFIG)/inc/osdep.h
DEPS_5 += $(CONFIG)/obj/mprLib.o

$(CONFIG)/bin/libmpr.a: $(DEPS_5)
	@echo '      [Link] $(CONFIG)/bin/libmpr.a'
	ar -cr $(CONFIG)/bin/libmpr.a "$(CONFIG)/obj/mprLib.o"

#
#   pcre.h
#
$(CONFIG)/inc/pcre.h: $(DEPS_6)
	@echo '      [Copy] $(CONFIG)/inc/pcre.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/pcre/pcre.h $(CONFIG)/inc/pcre.h

#
#   pcre.o
#
DEPS_7 += $(CONFIG)/inc/me.h
DEPS_7 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/pcre.o: \
    src/paks/pcre/pcre.c $(DEPS_7)
	@echo '   [Compile] $(CONFIG)/obj/pcre.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/pcre.o $(LDFLAGS) $(IFLAGS) src/paks/pcre/pcre.c

ifeq ($(ME_COM_PCRE),1)
#
#   libpcre
#
DEPS_8 += $(CONFIG)/inc/pcre.h
DEPS_8 += $(CONFIG)/inc/me.h
DEPS_8 += $(CONFIG)/obj/pcre.o

$(CONFIG)/bin/libpcre.a: $(DEPS_8)
	@echo '      [Link] $(CONFIG)/bin/libpcre.a'
	ar -cr $(CONFIG)/bin/libpcre.a "$(CONFIG)/obj/pcre.o"
endif

#
#   http.h
#
$(CONFIG)/inc/http.h: $(DEPS_9)
	@echo '      [Copy] $(CONFIG)/inc/http.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/http/http.h $(CONFIG)/inc/http.h

#
#   httpLib.o
#
DEPS_10 += $(CONFIG)/inc/me.h
DEPS_10 += $(CONFIG)/inc/http.h
DEPS_10 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/httpLib.o: \
    src/paks/http/httpLib.c $(DEPS_10)
	@echo '   [Compile] $(CONFIG)/obj/httpLib.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/httpLib.o $(LDFLAGS) $(IFLAGS) src/paks/http/httpLib.c

ifeq ($(ME_COM_HTTP),1)
#
#   libhttp
#
DEPS_11 += $(CONFIG)/inc/mpr.h
DEPS_11 += $(CONFIG)/inc/me.h
DEPS_11 += $(CONFIG)/inc/osdep.h
DEPS_11 += $(CONFIG)/obj/mprLib.o
DEPS_11 += $(CONFIG)/bin/libmpr.a
DEPS_11 += $(CONFIG)/inc/pcre.h
DEPS_11 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_11 += $(CONFIG)/bin/libpcre.a
endif
DEPS_11 += $(CONFIG)/inc/http.h
DEPS_11 += $(CONFIG)/obj/httpLib.o

$(CONFIG)/bin/libhttp.a: $(DEPS_11)
	@echo '      [Link] $(CONFIG)/bin/libhttp.a'
	ar -cr $(CONFIG)/bin/libhttp.a "$(CONFIG)/obj/httpLib.o"
endif

#
#   appweb.h
#
$(CONFIG)/inc/appweb.h: $(DEPS_12)
	@echo '      [Copy] $(CONFIG)/inc/appweb.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/appweb.h $(CONFIG)/inc/appweb.h

#
#   customize.h
#
$(CONFIG)/inc/customize.h: $(DEPS_13)
	@echo '      [Copy] $(CONFIG)/inc/customize.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/customize.h $(CONFIG)/inc/customize.h

#
#   config.o
#
DEPS_14 += $(CONFIG)/inc/me.h
DEPS_14 += $(CONFIG)/inc/appweb.h
DEPS_14 += $(CONFIG)/inc/pcre.h
DEPS_14 += $(CONFIG)/inc/mpr.h
DEPS_14 += $(CONFIG)/inc/http.h
DEPS_14 += $(CONFIG)/inc/customize.h

$(CONFIG)/obj/config.o: \
    src/config.c $(DEPS_14)
	@echo '   [Compile] $(CONFIG)/obj/config.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/config.o $(LDFLAGS) $(IFLAGS) src/config.c

#
#   convenience.o
#
DEPS_15 += $(CONFIG)/inc/me.h
DEPS_15 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/convenience.o: \
    src/convenience.c $(DEPS_15)
	@echo '   [Compile] $(CONFIG)/obj/convenience.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/convenience.o $(LDFLAGS) $(IFLAGS) src/convenience.c

#
#   dirHandler.o
#
DEPS_16 += $(CONFIG)/inc/me.h
DEPS_16 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/dirHandler.o: \
    src/dirHandler.c $(DEPS_16)
	@echo '   [Compile] $(CONFIG)/obj/dirHandler.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/dirHandler.o $(LDFLAGS) $(IFLAGS) src/dirHandler.c

#
#   fileHandler.o
#
DEPS_17 += $(CONFIG)/inc/me.h
DEPS_17 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/fileHandler.o: \
    src/fileHandler.c $(DEPS_17)
	@echo '   [Compile] $(CONFIG)/obj/fileHandler.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/fileHandler.o $(LDFLAGS) $(IFLAGS) src/fileHandler.c

#
#   log.o
#
DEPS_18 += $(CONFIG)/inc/me.h
DEPS_18 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/log.o: \
    src/log.c $(DEPS_18)
	@echo '   [Compile] $(CONFIG)/obj/log.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/log.o $(LDFLAGS) $(IFLAGS) src/log.c

#
#   server.o
#
DEPS_19 += $(CONFIG)/inc/me.h
DEPS_19 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/server.o: \
    src/server.c $(DEPS_19)
	@echo '   [Compile] $(CONFIG)/obj/server.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/server.o $(LDFLAGS) $(IFLAGS) src/server.c

#
#   libappweb
#
DEPS_20 += $(CONFIG)/inc/mpr.h
DEPS_20 += $(CONFIG)/inc/me.h
DEPS_20 += $(CONFIG)/inc/osdep.h
DEPS_20 += $(CONFIG)/obj/mprLib.o
DEPS_20 += $(CONFIG)/bin/libmpr.a
DEPS_20 += $(CONFIG)/inc/pcre.h
DEPS_20 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_20 += $(CONFIG)/bin/libpcre.a
endif
DEPS_20 += $(CONFIG)/inc/http.h
DEPS_20 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_20 += $(CONFIG)/bin/libhttp.a
endif
DEPS_20 += $(CONFIG)/inc/appweb.h
DEPS_20 += $(CONFIG)/inc/customize.h
DEPS_20 += $(CONFIG)/obj/config.o
DEPS_20 += $(CONFIG)/obj/convenience.o
DEPS_20 += $(CONFIG)/obj/dirHandler.o
DEPS_20 += $(CONFIG)/obj/fileHandler.o
DEPS_20 += $(CONFIG)/obj/log.o
DEPS_20 += $(CONFIG)/obj/server.o

$(CONFIG)/bin/libappweb.a: $(DEPS_20)
	@echo '      [Link] $(CONFIG)/bin/libappweb.a'
	ar -cr $(CONFIG)/bin/libappweb.a "$(CONFIG)/obj/config.o" "$(CONFIG)/obj/convenience.o" "$(CONFIG)/obj/dirHandler.o" "$(CONFIG)/obj/fileHandler.o" "$(CONFIG)/obj/log.o" "$(CONFIG)/obj/server.o"

#
#   slink.c
#
src/slink.c: $(DEPS_21)
	( \
	cd src; \
	[ ! -f slink.c ] && cp slink.empty slink.c ; true ; \
	)

#
#   edi.h
#
$(CONFIG)/inc/edi.h: $(DEPS_22)
	@echo '      [Copy] $(CONFIG)/inc/edi.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/esp/edi.h $(CONFIG)/inc/edi.h

#
#   esp.h
#
$(CONFIG)/inc/esp.h: $(DEPS_23)
	@echo '      [Copy] $(CONFIG)/inc/esp.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/esp/esp.h $(CONFIG)/inc/esp.h

#
#   mdb.h
#
$(CONFIG)/inc/mdb.h: $(DEPS_24)
	@echo '      [Copy] $(CONFIG)/inc/mdb.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/esp/mdb.h $(CONFIG)/inc/mdb.h

#
#   edi.o
#
DEPS_25 += $(CONFIG)/inc/me.h
DEPS_25 += $(CONFIG)/inc/edi.h
DEPS_25 += $(CONFIG)/inc/pcre.h
DEPS_25 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/edi.o: \
    src/paks/esp/edi.c $(DEPS_25)
	@echo '   [Compile] $(CONFIG)/obj/edi.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/edi.o $(LDFLAGS) $(IFLAGS) src/paks/esp/edi.c

#
#   espAbbrev.o
#
DEPS_26 += $(CONFIG)/inc/me.h
DEPS_26 += $(CONFIG)/inc/esp.h
DEPS_26 += $(CONFIG)/inc/appweb.h
DEPS_26 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espAbbrev.o: \
    src/paks/esp/espAbbrev.c $(DEPS_26)
	@echo '   [Compile] $(CONFIG)/obj/espAbbrev.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/espAbbrev.o $(LDFLAGS) $(IFLAGS) src/paks/esp/espAbbrev.c

#
#   espDeprecated.o
#
DEPS_27 += $(CONFIG)/inc/me.h
DEPS_27 += $(CONFIG)/inc/esp.h
DEPS_27 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espDeprecated.o: \
    src/paks/esp/espDeprecated.c $(DEPS_27)
	@echo '   [Compile] $(CONFIG)/obj/espDeprecated.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/espDeprecated.o $(LDFLAGS) $(IFLAGS) src/paks/esp/espDeprecated.c

#
#   espFramework.o
#
DEPS_28 += $(CONFIG)/inc/me.h
DEPS_28 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espFramework.o: \
    src/paks/esp/espFramework.c $(DEPS_28)
	@echo '   [Compile] $(CONFIG)/obj/espFramework.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/espFramework.o $(LDFLAGS) $(IFLAGS) src/paks/esp/espFramework.c

#
#   espHandler.o
#
DEPS_29 += $(CONFIG)/inc/me.h
DEPS_29 += $(CONFIG)/inc/appweb.h
DEPS_29 += $(CONFIG)/inc/esp.h
DEPS_29 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espHandler.o: \
    src/paks/esp/espHandler.c $(DEPS_29)
	@echo '   [Compile] $(CONFIG)/obj/espHandler.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/espHandler.o $(LDFLAGS) $(IFLAGS) src/paks/esp/espHandler.c

#
#   espHtml.o
#
DEPS_30 += $(CONFIG)/inc/me.h
DEPS_30 += $(CONFIG)/inc/esp.h
DEPS_30 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espHtml.o: \
    src/paks/esp/espHtml.c $(DEPS_30)
	@echo '   [Compile] $(CONFIG)/obj/espHtml.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/espHtml.o $(LDFLAGS) $(IFLAGS) src/paks/esp/espHtml.c

#
#   espTemplate.o
#
DEPS_31 += $(CONFIG)/inc/me.h
DEPS_31 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espTemplate.o: \
    src/paks/esp/espTemplate.c $(DEPS_31)
	@echo '   [Compile] $(CONFIG)/obj/espTemplate.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/espTemplate.o $(LDFLAGS) $(IFLAGS) src/paks/esp/espTemplate.c

#
#   mdb.o
#
DEPS_32 += $(CONFIG)/inc/me.h
DEPS_32 += $(CONFIG)/inc/appweb.h
DEPS_32 += $(CONFIG)/inc/edi.h
DEPS_32 += $(CONFIG)/inc/mdb.h
DEPS_32 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/mdb.o: \
    src/paks/esp/mdb.c $(DEPS_32)
	@echo '   [Compile] $(CONFIG)/obj/mdb.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/mdb.o $(LDFLAGS) $(IFLAGS) src/paks/esp/mdb.c

#
#   sdb.o
#
DEPS_33 += $(CONFIG)/inc/me.h
DEPS_33 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/sdb.o: \
    src/paks/esp/sdb.c $(DEPS_33)
	@echo '   [Compile] $(CONFIG)/obj/sdb.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/sdb.o $(LDFLAGS) $(IFLAGS) src/paks/esp/sdb.c

ifeq ($(ME_COM_ESP),1)
#
#   libmod_esp
#
DEPS_34 += $(CONFIG)/inc/mpr.h
DEPS_34 += $(CONFIG)/inc/me.h
DEPS_34 += $(CONFIG)/inc/osdep.h
DEPS_34 += $(CONFIG)/obj/mprLib.o
DEPS_34 += $(CONFIG)/bin/libmpr.a
DEPS_34 += $(CONFIG)/inc/pcre.h
DEPS_34 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_34 += $(CONFIG)/bin/libpcre.a
endif
DEPS_34 += $(CONFIG)/inc/http.h
DEPS_34 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_34 += $(CONFIG)/bin/libhttp.a
endif
DEPS_34 += $(CONFIG)/inc/appweb.h
DEPS_34 += $(CONFIG)/inc/customize.h
DEPS_34 += $(CONFIG)/obj/config.o
DEPS_34 += $(CONFIG)/obj/convenience.o
DEPS_34 += $(CONFIG)/obj/dirHandler.o
DEPS_34 += $(CONFIG)/obj/fileHandler.o
DEPS_34 += $(CONFIG)/obj/log.o
DEPS_34 += $(CONFIG)/obj/server.o
DEPS_34 += $(CONFIG)/bin/libappweb.a
DEPS_34 += $(CONFIG)/inc/edi.h
DEPS_34 += $(CONFIG)/inc/esp.h
DEPS_34 += $(CONFIG)/inc/mdb.h
DEPS_34 += $(CONFIG)/obj/edi.o
DEPS_34 += $(CONFIG)/obj/espAbbrev.o
DEPS_34 += $(CONFIG)/obj/espDeprecated.o
DEPS_34 += $(CONFIG)/obj/espFramework.o
DEPS_34 += $(CONFIG)/obj/espHandler.o
DEPS_34 += $(CONFIG)/obj/espHtml.o
DEPS_34 += $(CONFIG)/obj/espTemplate.o
DEPS_34 += $(CONFIG)/obj/mdb.o
DEPS_34 += $(CONFIG)/obj/sdb.o

$(CONFIG)/bin/libmod_esp.a: $(DEPS_34)
	@echo '      [Link] $(CONFIG)/bin/libmod_esp.a'
	ar -cr $(CONFIG)/bin/libmod_esp.a "$(CONFIG)/obj/edi.o" "$(CONFIG)/obj/espAbbrev.o" "$(CONFIG)/obj/espDeprecated.o" "$(CONFIG)/obj/espFramework.o" "$(CONFIG)/obj/espHandler.o" "$(CONFIG)/obj/espHtml.o" "$(CONFIG)/obj/espTemplate.o" "$(CONFIG)/obj/mdb.o" "$(CONFIG)/obj/sdb.o"
endif

#
#   slink.o
#
DEPS_35 += $(CONFIG)/inc/me.h
DEPS_35 += $(CONFIG)/inc/mpr.h
DEPS_35 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/slink.o: \
    src/slink.c $(DEPS_35)
	@echo '   [Compile] $(CONFIG)/obj/slink.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/slink.o $(LDFLAGS) $(IFLAGS) src/slink.c

#
#   libslink
#
DEPS_36 += src/slink.c
DEPS_36 += $(CONFIG)/inc/mpr.h
DEPS_36 += $(CONFIG)/inc/me.h
DEPS_36 += $(CONFIG)/inc/osdep.h
DEPS_36 += $(CONFIG)/obj/mprLib.o
DEPS_36 += $(CONFIG)/bin/libmpr.a
DEPS_36 += $(CONFIG)/inc/pcre.h
DEPS_36 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_36 += $(CONFIG)/bin/libpcre.a
endif
DEPS_36 += $(CONFIG)/inc/http.h
DEPS_36 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_36 += $(CONFIG)/bin/libhttp.a
endif
DEPS_36 += $(CONFIG)/inc/appweb.h
DEPS_36 += $(CONFIG)/inc/customize.h
DEPS_36 += $(CONFIG)/obj/config.o
DEPS_36 += $(CONFIG)/obj/convenience.o
DEPS_36 += $(CONFIG)/obj/dirHandler.o
DEPS_36 += $(CONFIG)/obj/fileHandler.o
DEPS_36 += $(CONFIG)/obj/log.o
DEPS_36 += $(CONFIG)/obj/server.o
DEPS_36 += $(CONFIG)/bin/libappweb.a
DEPS_36 += $(CONFIG)/inc/edi.h
DEPS_36 += $(CONFIG)/inc/esp.h
DEPS_36 += $(CONFIG)/inc/mdb.h
DEPS_36 += $(CONFIG)/obj/edi.o
DEPS_36 += $(CONFIG)/obj/espAbbrev.o
DEPS_36 += $(CONFIG)/obj/espDeprecated.o
DEPS_36 += $(CONFIG)/obj/espFramework.o
DEPS_36 += $(CONFIG)/obj/espHandler.o
DEPS_36 += $(CONFIG)/obj/espHtml.o
DEPS_36 += $(CONFIG)/obj/espTemplate.o
DEPS_36 += $(CONFIG)/obj/mdb.o
DEPS_36 += $(CONFIG)/obj/sdb.o
ifeq ($(ME_COM_ESP),1)
    DEPS_36 += $(CONFIG)/bin/libmod_esp.a
endif
DEPS_36 += $(CONFIG)/obj/slink.o

$(CONFIG)/bin/libslink.a: $(DEPS_36)
	@echo '      [Link] $(CONFIG)/bin/libslink.a'
	ar -cr $(CONFIG)/bin/libslink.a "$(CONFIG)/obj/slink.o"

#
#   est.h
#
$(CONFIG)/inc/est.h: $(DEPS_37)
	@echo '      [Copy] $(CONFIG)/inc/est.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/est/est.h $(CONFIG)/inc/est.h

#
#   estLib.o
#
DEPS_38 += $(CONFIG)/inc/me.h
DEPS_38 += $(CONFIG)/inc/est.h
DEPS_38 += $(CONFIG)/inc/osdep.h

$(CONFIG)/obj/estLib.o: \
    src/paks/est/estLib.c $(DEPS_38)
	@echo '   [Compile] $(CONFIG)/obj/estLib.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/estLib.o $(LDFLAGS) $(IFLAGS) src/paks/est/estLib.c

ifeq ($(ME_COM_EST),1)
#
#   libest
#
DEPS_39 += $(CONFIG)/inc/est.h
DEPS_39 += $(CONFIG)/inc/me.h
DEPS_39 += $(CONFIG)/inc/osdep.h
DEPS_39 += $(CONFIG)/obj/estLib.o

$(CONFIG)/bin/libest.a: $(DEPS_39)
	@echo '      [Link] $(CONFIG)/bin/libest.a'
	ar -cr $(CONFIG)/bin/libest.a "$(CONFIG)/obj/estLib.o"
endif

#
#   mprSsl.o
#
DEPS_40 += $(CONFIG)/inc/me.h
DEPS_40 += $(CONFIG)/inc/mpr.h
DEPS_40 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/mprSsl.o: \
    src/paks/mpr/mprSsl.c $(DEPS_40)
	@echo '   [Compile] $(CONFIG)/obj/mprSsl.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/mprSsl.o $(LDFLAGS) $(IFLAGS) "-I$(ME_COM_OPENSSL_PATH)/include" "-I$(ME_COM_MATRIXSSL_PATH)" "-I$(ME_COM_MATRIXSSL_PATH)/matrixssl" "-I$(ME_COM_NANOSSL_PATH)/src" src/paks/mpr/mprSsl.c

#
#   libmprssl
#
DEPS_41 += $(CONFIG)/inc/mpr.h
DEPS_41 += $(CONFIG)/inc/me.h
DEPS_41 += $(CONFIG)/inc/osdep.h
DEPS_41 += $(CONFIG)/obj/mprLib.o
DEPS_41 += $(CONFIG)/bin/libmpr.a
DEPS_41 += $(CONFIG)/inc/est.h
DEPS_41 += $(CONFIG)/obj/estLib.o
ifeq ($(ME_COM_EST),1)
    DEPS_41 += $(CONFIG)/bin/libest.a
endif
DEPS_41 += $(CONFIG)/obj/mprSsl.o

$(CONFIG)/bin/libmprssl.a: $(DEPS_41)
	@echo '      [Link] $(CONFIG)/bin/libmprssl.a'
	ar -cr $(CONFIG)/bin/libmprssl.a "$(CONFIG)/obj/mprSsl.o"

#
#   sslModule.o
#
DEPS_42 += $(CONFIG)/inc/me.h
DEPS_42 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/sslModule.o: \
    src/modules/sslModule.c $(DEPS_42)
	@echo '   [Compile] $(CONFIG)/obj/sslModule.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/sslModule.o $(LDFLAGS) $(IFLAGS) "-I$(ME_COM_OPENSSL_PATH)/include" "-I$(ME_COM_MATRIXSSL_PATH)" "-I$(ME_COM_MATRIXSSL_PATH)/matrixssl" "-I$(ME_COM_NANOSSL_PATH)/src" src/modules/sslModule.c

ifeq ($(ME_COM_SSL),1)
#
#   libmod_ssl
#
DEPS_43 += $(CONFIG)/inc/mpr.h
DEPS_43 += $(CONFIG)/inc/me.h
DEPS_43 += $(CONFIG)/inc/osdep.h
DEPS_43 += $(CONFIG)/obj/mprLib.o
DEPS_43 += $(CONFIG)/bin/libmpr.a
DEPS_43 += $(CONFIG)/inc/pcre.h
DEPS_43 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_43 += $(CONFIG)/bin/libpcre.a
endif
DEPS_43 += $(CONFIG)/inc/http.h
DEPS_43 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_43 += $(CONFIG)/bin/libhttp.a
endif
DEPS_43 += $(CONFIG)/inc/appweb.h
DEPS_43 += $(CONFIG)/inc/customize.h
DEPS_43 += $(CONFIG)/obj/config.o
DEPS_43 += $(CONFIG)/obj/convenience.o
DEPS_43 += $(CONFIG)/obj/dirHandler.o
DEPS_43 += $(CONFIG)/obj/fileHandler.o
DEPS_43 += $(CONFIG)/obj/log.o
DEPS_43 += $(CONFIG)/obj/server.o
DEPS_43 += $(CONFIG)/bin/libappweb.a
DEPS_43 += $(CONFIG)/inc/est.h
DEPS_43 += $(CONFIG)/obj/estLib.o
ifeq ($(ME_COM_EST),1)
    DEPS_43 += $(CONFIG)/bin/libest.a
endif
DEPS_43 += $(CONFIG)/obj/mprSsl.o
DEPS_43 += $(CONFIG)/bin/libmprssl.a
DEPS_43 += $(CONFIG)/obj/sslModule.o

$(CONFIG)/bin/libmod_ssl.a: $(DEPS_43)
	@echo '      [Link] $(CONFIG)/bin/libmod_ssl.a'
	ar -cr $(CONFIG)/bin/libmod_ssl.a "$(CONFIG)/obj/sslModule.o"
endif

#
#   zlib.h
#
$(CONFIG)/inc/zlib.h: $(DEPS_44)
	@echo '      [Copy] $(CONFIG)/inc/zlib.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/zlib/zlib.h $(CONFIG)/inc/zlib.h

#
#   zlib.o
#
DEPS_45 += $(CONFIG)/inc/me.h
DEPS_45 += $(CONFIG)/inc/zlib.h

$(CONFIG)/obj/zlib.o: \
    src/paks/zlib/zlib.c $(DEPS_45)
	@echo '   [Compile] $(CONFIG)/obj/zlib.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/zlib.o $(LDFLAGS) $(IFLAGS) src/paks/zlib/zlib.c

ifeq ($(ME_COM_ZLIB),1)
#
#   libzlib
#
DEPS_46 += $(CONFIG)/inc/zlib.h
DEPS_46 += $(CONFIG)/inc/me.h
DEPS_46 += $(CONFIG)/obj/zlib.o

$(CONFIG)/bin/libzlib.a: $(DEPS_46)
	@echo '      [Link] $(CONFIG)/bin/libzlib.a'
	ar -cr $(CONFIG)/bin/libzlib.a "$(CONFIG)/obj/zlib.o"
endif

#
#   ejs.h
#
$(CONFIG)/inc/ejs.h: $(DEPS_47)
	@echo '      [Copy] $(CONFIG)/inc/ejs.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/ejs/ejs.h $(CONFIG)/inc/ejs.h

#
#   ejs.slots.h
#
$(CONFIG)/inc/ejs.slots.h: $(DEPS_48)
	@echo '      [Copy] $(CONFIG)/inc/ejs.slots.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/ejs/ejs.slots.h $(CONFIG)/inc/ejs.slots.h

#
#   ejsByteGoto.h
#
$(CONFIG)/inc/ejsByteGoto.h: $(DEPS_49)
	@echo '      [Copy] $(CONFIG)/inc/ejsByteGoto.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/ejs/ejsByteGoto.h $(CONFIG)/inc/ejsByteGoto.h

#
#   ejsLib.o
#
DEPS_50 += $(CONFIG)/inc/me.h
DEPS_50 += $(CONFIG)/inc/ejs.h
DEPS_50 += $(CONFIG)/inc/mpr.h
DEPS_50 += $(CONFIG)/inc/pcre.h
DEPS_50 += $(CONFIG)/inc/osdep.h
DEPS_50 += $(CONFIG)/inc/http.h
DEPS_50 += $(CONFIG)/inc/ejs.slots.h

$(CONFIG)/obj/ejsLib.o: \
    src/paks/ejs/ejsLib.c $(DEPS_50)
	@echo '   [Compile] $(CONFIG)/obj/ejsLib.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/ejsLib.o $(LDFLAGS) $(IFLAGS) src/paks/ejs/ejsLib.c

ifeq ($(ME_COM_EJS),1)
#
#   libejs
#
DEPS_51 += $(CONFIG)/inc/mpr.h
DEPS_51 += $(CONFIG)/inc/me.h
DEPS_51 += $(CONFIG)/inc/osdep.h
DEPS_51 += $(CONFIG)/obj/mprLib.o
DEPS_51 += $(CONFIG)/bin/libmpr.a
DEPS_51 += $(CONFIG)/inc/pcre.h
DEPS_51 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_51 += $(CONFIG)/bin/libpcre.a
endif
DEPS_51 += $(CONFIG)/inc/http.h
DEPS_51 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_51 += $(CONFIG)/bin/libhttp.a
endif
DEPS_51 += $(CONFIG)/inc/zlib.h
DEPS_51 += $(CONFIG)/obj/zlib.o
ifeq ($(ME_COM_ZLIB),1)
    DEPS_51 += $(CONFIG)/bin/libzlib.a
endif
DEPS_51 += $(CONFIG)/inc/ejs.h
DEPS_51 += $(CONFIG)/inc/ejs.slots.h
DEPS_51 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_51 += $(CONFIG)/obj/ejsLib.o

$(CONFIG)/bin/libejs.a: $(DEPS_51)
	@echo '      [Link] $(CONFIG)/bin/libejs.a'
	ar -cr $(CONFIG)/bin/libejs.a "$(CONFIG)/obj/ejsLib.o"
endif

#
#   ejsHandler.o
#
DEPS_52 += $(CONFIG)/inc/me.h
DEPS_52 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/ejsHandler.o: \
    src/modules/ejsHandler.c $(DEPS_52)
	@echo '   [Compile] $(CONFIG)/obj/ejsHandler.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/ejsHandler.o $(LDFLAGS) $(IFLAGS) src/modules/ejsHandler.c

ifeq ($(ME_COM_EJS),1)
#
#   libmod_ejs
#
DEPS_53 += $(CONFIG)/inc/mpr.h
DEPS_53 += $(CONFIG)/inc/me.h
DEPS_53 += $(CONFIG)/inc/osdep.h
DEPS_53 += $(CONFIG)/obj/mprLib.o
DEPS_53 += $(CONFIG)/bin/libmpr.a
DEPS_53 += $(CONFIG)/inc/pcre.h
DEPS_53 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_53 += $(CONFIG)/bin/libpcre.a
endif
DEPS_53 += $(CONFIG)/inc/http.h
DEPS_53 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_53 += $(CONFIG)/bin/libhttp.a
endif
DEPS_53 += $(CONFIG)/inc/appweb.h
DEPS_53 += $(CONFIG)/inc/customize.h
DEPS_53 += $(CONFIG)/obj/config.o
DEPS_53 += $(CONFIG)/obj/convenience.o
DEPS_53 += $(CONFIG)/obj/dirHandler.o
DEPS_53 += $(CONFIG)/obj/fileHandler.o
DEPS_53 += $(CONFIG)/obj/log.o
DEPS_53 += $(CONFIG)/obj/server.o
DEPS_53 += $(CONFIG)/bin/libappweb.a
DEPS_53 += $(CONFIG)/inc/zlib.h
DEPS_53 += $(CONFIG)/obj/zlib.o
ifeq ($(ME_COM_ZLIB),1)
    DEPS_53 += $(CONFIG)/bin/libzlib.a
endif
DEPS_53 += $(CONFIG)/inc/ejs.h
DEPS_53 += $(CONFIG)/inc/ejs.slots.h
DEPS_53 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_53 += $(CONFIG)/obj/ejsLib.o
DEPS_53 += $(CONFIG)/bin/libejs.a
DEPS_53 += $(CONFIG)/obj/ejsHandler.o

$(CONFIG)/bin/libmod_ejs.a: $(DEPS_53)
	@echo '      [Link] $(CONFIG)/bin/libmod_ejs.a'
	ar -cr $(CONFIG)/bin/libmod_ejs.a "$(CONFIG)/obj/ejsHandler.o"
endif

#
#   phpHandler.o
#
DEPS_54 += $(CONFIG)/inc/me.h
DEPS_54 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/phpHandler.o: \
    src/modules/phpHandler.c $(DEPS_54)
	@echo '   [Compile] $(CONFIG)/obj/phpHandler.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/phpHandler.o $(LDFLAGS) $(IFLAGS) "-I$(ME_COM_PHP_PATH)" "-I$(ME_COM_PHP_PATH)/main" "-I$(ME_COM_PHP_PATH)/Zend" "-I$(ME_COM_PHP_PATH)/TSRM" src/modules/phpHandler.c

ifeq ($(ME_COM_PHP),1)
#
#   libmod_php
#
DEPS_55 += $(CONFIG)/inc/mpr.h
DEPS_55 += $(CONFIG)/inc/me.h
DEPS_55 += $(CONFIG)/inc/osdep.h
DEPS_55 += $(CONFIG)/obj/mprLib.o
DEPS_55 += $(CONFIG)/bin/libmpr.a
DEPS_55 += $(CONFIG)/inc/pcre.h
DEPS_55 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_55 += $(CONFIG)/bin/libpcre.a
endif
DEPS_55 += $(CONFIG)/inc/http.h
DEPS_55 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_55 += $(CONFIG)/bin/libhttp.a
endif
DEPS_55 += $(CONFIG)/inc/appweb.h
DEPS_55 += $(CONFIG)/inc/customize.h
DEPS_55 += $(CONFIG)/obj/config.o
DEPS_55 += $(CONFIG)/obj/convenience.o
DEPS_55 += $(CONFIG)/obj/dirHandler.o
DEPS_55 += $(CONFIG)/obj/fileHandler.o
DEPS_55 += $(CONFIG)/obj/log.o
DEPS_55 += $(CONFIG)/obj/server.o
DEPS_55 += $(CONFIG)/bin/libappweb.a
DEPS_55 += $(CONFIG)/obj/phpHandler.o

$(CONFIG)/bin/libmod_php.a: $(DEPS_55)
	@echo '      [Link] $(CONFIG)/bin/libmod_php.a'
	ar -cr $(CONFIG)/bin/libmod_php.a "$(CONFIG)/obj/phpHandler.o"
endif

#
#   cgiHandler.o
#
DEPS_56 += $(CONFIG)/inc/me.h
DEPS_56 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/cgiHandler.o: \
    src/modules/cgiHandler.c $(DEPS_56)
	@echo '   [Compile] $(CONFIG)/obj/cgiHandler.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/cgiHandler.o $(LDFLAGS) $(IFLAGS) src/modules/cgiHandler.c

ifeq ($(ME_COM_CGI),1)
#
#   libmod_cgi
#
DEPS_57 += $(CONFIG)/inc/mpr.h
DEPS_57 += $(CONFIG)/inc/me.h
DEPS_57 += $(CONFIG)/inc/osdep.h
DEPS_57 += $(CONFIG)/obj/mprLib.o
DEPS_57 += $(CONFIG)/bin/libmpr.a
DEPS_57 += $(CONFIG)/inc/pcre.h
DEPS_57 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_57 += $(CONFIG)/bin/libpcre.a
endif
DEPS_57 += $(CONFIG)/inc/http.h
DEPS_57 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_57 += $(CONFIG)/bin/libhttp.a
endif
DEPS_57 += $(CONFIG)/inc/appweb.h
DEPS_57 += $(CONFIG)/inc/customize.h
DEPS_57 += $(CONFIG)/obj/config.o
DEPS_57 += $(CONFIG)/obj/convenience.o
DEPS_57 += $(CONFIG)/obj/dirHandler.o
DEPS_57 += $(CONFIG)/obj/fileHandler.o
DEPS_57 += $(CONFIG)/obj/log.o
DEPS_57 += $(CONFIG)/obj/server.o
DEPS_57 += $(CONFIG)/bin/libappweb.a
DEPS_57 += $(CONFIG)/obj/cgiHandler.o

$(CONFIG)/bin/libmod_cgi.a: $(DEPS_57)
	@echo '      [Link] $(CONFIG)/bin/libmod_cgi.a'
	ar -cr $(CONFIG)/bin/libmod_cgi.a "$(CONFIG)/obj/cgiHandler.o"
endif

#
#   appweb.o
#
DEPS_58 += $(CONFIG)/inc/me.h
DEPS_58 += $(CONFIG)/inc/appweb.h
DEPS_58 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/appweb.o: \
    src/server/appweb.c $(DEPS_58)
	@echo '   [Compile] $(CONFIG)/obj/appweb.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/appweb.o $(LDFLAGS) $(IFLAGS) "-I$(ME_COM_OPENSSL_PATH)/include" "-I$(ME_COM_MATRIXSSL_PATH)" "-I$(ME_COM_MATRIXSSL_PATH)/matrixssl" "-I$(ME_COM_NANOSSL_PATH)/src" "-I$(ME_COM_PHP_PATH)" "-I$(ME_COM_PHP_PATH)/main" "-I$(ME_COM_PHP_PATH)/Zend" "-I$(ME_COM_PHP_PATH)/TSRM" src/server/appweb.c

#
#   appweb
#
DEPS_59 += $(CONFIG)/inc/mpr.h
DEPS_59 += $(CONFIG)/inc/me.h
DEPS_59 += $(CONFIG)/inc/osdep.h
DEPS_59 += $(CONFIG)/obj/mprLib.o
DEPS_59 += $(CONFIG)/bin/libmpr.a
DEPS_59 += $(CONFIG)/inc/pcre.h
DEPS_59 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_59 += $(CONFIG)/bin/libpcre.a
endif
DEPS_59 += $(CONFIG)/inc/http.h
DEPS_59 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_59 += $(CONFIG)/bin/libhttp.a
endif
DEPS_59 += $(CONFIG)/inc/appweb.h
DEPS_59 += $(CONFIG)/inc/customize.h
DEPS_59 += $(CONFIG)/obj/config.o
DEPS_59 += $(CONFIG)/obj/convenience.o
DEPS_59 += $(CONFIG)/obj/dirHandler.o
DEPS_59 += $(CONFIG)/obj/fileHandler.o
DEPS_59 += $(CONFIG)/obj/log.o
DEPS_59 += $(CONFIG)/obj/server.o
DEPS_59 += $(CONFIG)/bin/libappweb.a
DEPS_59 += src/slink.c
DEPS_59 += $(CONFIG)/inc/edi.h
DEPS_59 += $(CONFIG)/inc/esp.h
DEPS_59 += $(CONFIG)/inc/mdb.h
DEPS_59 += $(CONFIG)/obj/edi.o
DEPS_59 += $(CONFIG)/obj/espAbbrev.o
DEPS_59 += $(CONFIG)/obj/espDeprecated.o
DEPS_59 += $(CONFIG)/obj/espFramework.o
DEPS_59 += $(CONFIG)/obj/espHandler.o
DEPS_59 += $(CONFIG)/obj/espHtml.o
DEPS_59 += $(CONFIG)/obj/espTemplate.o
DEPS_59 += $(CONFIG)/obj/mdb.o
DEPS_59 += $(CONFIG)/obj/sdb.o
ifeq ($(ME_COM_ESP),1)
    DEPS_59 += $(CONFIG)/bin/libmod_esp.a
endif
DEPS_59 += $(CONFIG)/obj/slink.o
DEPS_59 += $(CONFIG)/bin/libslink.a
DEPS_59 += $(CONFIG)/inc/est.h
DEPS_59 += $(CONFIG)/obj/estLib.o
ifeq ($(ME_COM_EST),1)
    DEPS_59 += $(CONFIG)/bin/libest.a
endif
DEPS_59 += $(CONFIG)/obj/mprSsl.o
DEPS_59 += $(CONFIG)/bin/libmprssl.a
DEPS_59 += $(CONFIG)/obj/sslModule.o
ifeq ($(ME_COM_SSL),1)
    DEPS_59 += $(CONFIG)/bin/libmod_ssl.a
endif
DEPS_59 += $(CONFIG)/inc/zlib.h
DEPS_59 += $(CONFIG)/obj/zlib.o
ifeq ($(ME_COM_ZLIB),1)
    DEPS_59 += $(CONFIG)/bin/libzlib.a
endif
DEPS_59 += $(CONFIG)/inc/ejs.h
DEPS_59 += $(CONFIG)/inc/ejs.slots.h
DEPS_59 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_59 += $(CONFIG)/obj/ejsLib.o
ifeq ($(ME_COM_EJS),1)
    DEPS_59 += $(CONFIG)/bin/libejs.a
endif
DEPS_59 += $(CONFIG)/obj/ejsHandler.o
ifeq ($(ME_COM_EJS),1)
    DEPS_59 += $(CONFIG)/bin/libmod_ejs.a
endif
DEPS_59 += $(CONFIG)/obj/phpHandler.o
ifeq ($(ME_COM_PHP),1)
    DEPS_59 += $(CONFIG)/bin/libmod_php.a
endif
DEPS_59 += $(CONFIG)/obj/cgiHandler.o
ifeq ($(ME_COM_CGI),1)
    DEPS_59 += $(CONFIG)/bin/libmod_cgi.a
endif
DEPS_59 += $(CONFIG)/obj/appweb.o

LIBS_59 += -lappweb
ifeq ($(ME_COM_HTTP),1)
    LIBS_59 += -lhttp
endif
LIBS_59 += -lmpr
ifeq ($(ME_COM_PCRE),1)
    LIBS_59 += -lpcre
endif
LIBS_59 += -lslink
ifeq ($(ME_COM_ESP),1)
    LIBS_59 += -lmod_esp
endif
ifeq ($(ME_COM_SQLITE),1)
    LIBS_59 += -lsql
endif
ifeq ($(ME_COM_SSL),1)
    LIBS_59 += -lmod_ssl
endif
LIBS_59 += -lmprssl
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_59 += -lssl
    LIBPATHS_59 += -L$(ME_COM_OPENSSL_PATH)
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_59 += -lcrypto
    LIBPATHS_59 += -L$(ME_COM_OPENSSL_PATH)
endif
ifeq ($(ME_COM_EST),1)
    LIBS_59 += -lest
endif
ifeq ($(ME_COM_MATRIXSSL),1)
    LIBS_59 += -lmatrixssl
    LIBPATHS_59 += -L$(ME_COM_MATRIXSSL_PATH)
endif
ifeq ($(ME_COM_NANOSSL),1)
    LIBS_59 += -lssls
    LIBPATHS_59 += -L$(ME_COM_NANOSSL_PATH)/bin
endif
ifeq ($(ME_COM_EJS),1)
    LIBS_59 += -lmod_ejs
endif
ifeq ($(ME_COM_EJS),1)
    LIBS_59 += -lejs
endif
ifeq ($(ME_COM_ZLIB),1)
    LIBS_59 += -lzlib
endif
ifeq ($(ME_COM_PHP),1)
    LIBS_59 += -lmod_php
endif
ifeq ($(ME_COM_PHP),1)
    LIBS_59 += -lphp5
    LIBPATHS_59 += -L$(ME_COM_PHP_PATH)/libs
endif
ifeq ($(ME_COM_CGI),1)
    LIBS_59 += -lmod_cgi
endif

$(CONFIG)/bin/appweb: $(DEPS_59)
	@echo '      [Link] $(CONFIG)/bin/appweb'
	$(CC) -o $(CONFIG)/bin/appweb $(LDFLAGS) $(LIBPATHS)     "$(CONFIG)/obj/appweb.o" $(LIBPATHS_59) $(LIBS_59) $(LIBS_59) $(LIBS) $(LIBS) 

#
#   authpass.o
#
DEPS_60 += $(CONFIG)/inc/me.h
DEPS_60 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/authpass.o: \
    src/utils/authpass.c $(DEPS_60)
	@echo '   [Compile] $(CONFIG)/obj/authpass.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/authpass.o $(LDFLAGS) $(IFLAGS) src/utils/authpass.c

#
#   authpass
#
DEPS_61 += $(CONFIG)/inc/mpr.h
DEPS_61 += $(CONFIG)/inc/me.h
DEPS_61 += $(CONFIG)/inc/osdep.h
DEPS_61 += $(CONFIG)/obj/mprLib.o
DEPS_61 += $(CONFIG)/bin/libmpr.a
DEPS_61 += $(CONFIG)/inc/pcre.h
DEPS_61 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_61 += $(CONFIG)/bin/libpcre.a
endif
DEPS_61 += $(CONFIG)/inc/http.h
DEPS_61 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_61 += $(CONFIG)/bin/libhttp.a
endif
DEPS_61 += $(CONFIG)/inc/appweb.h
DEPS_61 += $(CONFIG)/inc/customize.h
DEPS_61 += $(CONFIG)/obj/config.o
DEPS_61 += $(CONFIG)/obj/convenience.o
DEPS_61 += $(CONFIG)/obj/dirHandler.o
DEPS_61 += $(CONFIG)/obj/fileHandler.o
DEPS_61 += $(CONFIG)/obj/log.o
DEPS_61 += $(CONFIG)/obj/server.o
DEPS_61 += $(CONFIG)/bin/libappweb.a
DEPS_61 += $(CONFIG)/obj/authpass.o

LIBS_61 += -lappweb
ifeq ($(ME_COM_HTTP),1)
    LIBS_61 += -lhttp
endif
LIBS_61 += -lmpr
ifeq ($(ME_COM_PCRE),1)
    LIBS_61 += -lpcre
endif

$(CONFIG)/bin/authpass: $(DEPS_61)
	@echo '      [Link] $(CONFIG)/bin/authpass'
	$(CC) -o $(CONFIG)/bin/authpass $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/authpass.o" $(LIBPATHS_61) $(LIBS_61) $(LIBS_61) $(LIBS) $(LIBS) 

#
#   cgiProgram.o
#
DEPS_62 += $(CONFIG)/inc/me.h

$(CONFIG)/obj/cgiProgram.o: \
    src/utils/cgiProgram.c $(DEPS_62)
	@echo '   [Compile] $(CONFIG)/obj/cgiProgram.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/cgiProgram.o $(LDFLAGS) $(IFLAGS) src/utils/cgiProgram.c

ifeq ($(ME_COM_CGI),1)
#
#   cgiProgram
#
DEPS_63 += $(CONFIG)/inc/me.h
DEPS_63 += $(CONFIG)/obj/cgiProgram.o

$(CONFIG)/bin/cgiProgram: $(DEPS_63)
	@echo '      [Link] $(CONFIG)/bin/cgiProgram'
	$(CC) -o $(CONFIG)/bin/cgiProgram $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/cgiProgram.o" $(LIBS) $(LIBS) 
endif

#
#   ejsc.o
#
DEPS_64 += $(CONFIG)/inc/me.h
DEPS_64 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsc.o: \
    src/paks/ejs/ejsc.c $(DEPS_64)
	@echo '   [Compile] $(CONFIG)/obj/ejsc.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/ejsc.o $(LDFLAGS) $(IFLAGS) src/paks/ejs/ejsc.c

ifeq ($(ME_COM_EJS),1)
#
#   ejsc
#
DEPS_65 += $(CONFIG)/inc/mpr.h
DEPS_65 += $(CONFIG)/inc/me.h
DEPS_65 += $(CONFIG)/inc/osdep.h
DEPS_65 += $(CONFIG)/obj/mprLib.o
DEPS_65 += $(CONFIG)/bin/libmpr.a
DEPS_65 += $(CONFIG)/inc/pcre.h
DEPS_65 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_65 += $(CONFIG)/bin/libpcre.a
endif
DEPS_65 += $(CONFIG)/inc/http.h
DEPS_65 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_65 += $(CONFIG)/bin/libhttp.a
endif
DEPS_65 += $(CONFIG)/inc/zlib.h
DEPS_65 += $(CONFIG)/obj/zlib.o
ifeq ($(ME_COM_ZLIB),1)
    DEPS_65 += $(CONFIG)/bin/libzlib.a
endif
DEPS_65 += $(CONFIG)/inc/ejs.h
DEPS_65 += $(CONFIG)/inc/ejs.slots.h
DEPS_65 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_65 += $(CONFIG)/obj/ejsLib.o
DEPS_65 += $(CONFIG)/bin/libejs.a
DEPS_65 += $(CONFIG)/obj/ejsc.o

LIBS_65 += -lejs
ifeq ($(ME_COM_HTTP),1)
    LIBS_65 += -lhttp
endif
LIBS_65 += -lmpr
ifeq ($(ME_COM_PCRE),1)
    LIBS_65 += -lpcre
endif
ifeq ($(ME_COM_ZLIB),1)
    LIBS_65 += -lzlib
endif
ifeq ($(ME_COM_SQLITE),1)
    LIBS_65 += -lsql
endif

$(CONFIG)/bin/ejsc: $(DEPS_65)
	@echo '      [Link] $(CONFIG)/bin/ejsc'
	$(CC) -o $(CONFIG)/bin/ejsc $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsc.o" $(LIBPATHS_65) $(LIBS_65) $(LIBS_65) $(LIBS) $(LIBS) 
endif

ifeq ($(ME_COM_EJS),1)
#
#   ejs.mod
#
DEPS_66 += src/paks/ejs/ejs.es
DEPS_66 += $(CONFIG)/inc/mpr.h
DEPS_66 += $(CONFIG)/inc/me.h
DEPS_66 += $(CONFIG)/inc/osdep.h
DEPS_66 += $(CONFIG)/obj/mprLib.o
DEPS_66 += $(CONFIG)/bin/libmpr.a
DEPS_66 += $(CONFIG)/inc/pcre.h
DEPS_66 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_66 += $(CONFIG)/bin/libpcre.a
endif
DEPS_66 += $(CONFIG)/inc/http.h
DEPS_66 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_66 += $(CONFIG)/bin/libhttp.a
endif
DEPS_66 += $(CONFIG)/inc/zlib.h
DEPS_66 += $(CONFIG)/obj/zlib.o
ifeq ($(ME_COM_ZLIB),1)
    DEPS_66 += $(CONFIG)/bin/libzlib.a
endif
DEPS_66 += $(CONFIG)/inc/ejs.h
DEPS_66 += $(CONFIG)/inc/ejs.slots.h
DEPS_66 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_66 += $(CONFIG)/obj/ejsLib.o
DEPS_66 += $(CONFIG)/bin/libejs.a
DEPS_66 += $(CONFIG)/obj/ejsc.o
DEPS_66 += $(CONFIG)/bin/ejsc

$(CONFIG)/bin/ejs.mod: $(DEPS_66)
	( \
	cd src/paks/ejs; \
	../../../$(LBIN)/ejsc --out ../../../$(CONFIG)/bin/ejs.mod --optimize 9 --bind --require null ejs.es ; \
	)
endif

#
#   ejs.o
#
DEPS_67 += $(CONFIG)/inc/me.h
DEPS_67 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejs.o: \
    src/paks/ejs/ejs.c $(DEPS_67)
	@echo '   [Compile] $(CONFIG)/obj/ejs.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/ejs.o $(LDFLAGS) $(IFLAGS) src/paks/ejs/ejs.c

ifeq ($(ME_COM_EJS),1)
#
#   ejscmd
#
DEPS_68 += $(CONFIG)/inc/mpr.h
DEPS_68 += $(CONFIG)/inc/me.h
DEPS_68 += $(CONFIG)/inc/osdep.h
DEPS_68 += $(CONFIG)/obj/mprLib.o
DEPS_68 += $(CONFIG)/bin/libmpr.a
DEPS_68 += $(CONFIG)/inc/pcre.h
DEPS_68 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_68 += $(CONFIG)/bin/libpcre.a
endif
DEPS_68 += $(CONFIG)/inc/http.h
DEPS_68 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_68 += $(CONFIG)/bin/libhttp.a
endif
DEPS_68 += $(CONFIG)/inc/zlib.h
DEPS_68 += $(CONFIG)/obj/zlib.o
ifeq ($(ME_COM_ZLIB),1)
    DEPS_68 += $(CONFIG)/bin/libzlib.a
endif
DEPS_68 += $(CONFIG)/inc/ejs.h
DEPS_68 += $(CONFIG)/inc/ejs.slots.h
DEPS_68 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_68 += $(CONFIG)/obj/ejsLib.o
DEPS_68 += $(CONFIG)/bin/libejs.a
DEPS_68 += $(CONFIG)/obj/ejs.o

LIBS_68 += -lejs
ifeq ($(ME_COM_HTTP),1)
    LIBS_68 += -lhttp
endif
LIBS_68 += -lmpr
ifeq ($(ME_COM_PCRE),1)
    LIBS_68 += -lpcre
endif
ifeq ($(ME_COM_ZLIB),1)
    LIBS_68 += -lzlib
endif
ifeq ($(ME_COM_SQLITE),1)
    LIBS_68 += -lsql
endif

$(CONFIG)/bin/ejs: $(DEPS_68)
	@echo '      [Link] $(CONFIG)/bin/ejs'
	$(CC) -o $(CONFIG)/bin/ejs $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejs.o" $(LIBPATHS_68) $(LIBS_68) $(LIBS_68) $(LIBS) $(LIBS) 
endif

ifeq ($(ME_COM_ESP),1)
#
#   esp-paks
#
DEPS_69 += src/paks/esp-angular
DEPS_69 += src/paks/esp-angular/esp-click.js
DEPS_69 += src/paks/esp-angular/esp-edit.js
DEPS_69 += src/paks/esp-angular/esp-field-errors.js
DEPS_69 += src/paks/esp-angular/esp-fixnum.js
DEPS_69 += src/paks/esp-angular/esp-format.js
DEPS_69 += src/paks/esp-angular/esp-input-group.js
DEPS_69 += src/paks/esp-angular/esp-input.js
DEPS_69 += src/paks/esp-angular/esp-resource.js
DEPS_69 += src/paks/esp-angular/esp-session.js
DEPS_69 += src/paks/esp-angular/esp-titlecase.js
DEPS_69 += src/paks/esp-angular/esp.js
DEPS_69 += src/paks/esp-angular/package.json
DEPS_69 += src/paks/esp-angular-mvc
DEPS_69 += src/paks/esp-angular-mvc/package.json
DEPS_69 += src/paks/esp-angular-mvc/templates
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/appweb.conf
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/app
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/app/main.js
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/assets
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/assets/favicon.ico
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/all.css
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/all.less
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/app.less
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/fix.css
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/theme.less
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/index.esp
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/pages
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/pages/splash.html
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/controller-singleton.c
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/controller.c
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/controller.js
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/edit.html
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/list.html
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/model.js
DEPS_69 += src/paks/esp-angular-mvc/templates/esp-angular-mvc/start.me
DEPS_69 += src/paks/esp-html-mvc
DEPS_69 += src/paks/esp-html-mvc/package.json
DEPS_69 += src/paks/esp-html-mvc/templates
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/appweb.conf
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/assets
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/assets/favicon.ico
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/css
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/all.css
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/all.less
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/app.less
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/theme.less
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/index.esp
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/layouts
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/client/layouts/default.esp
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/controller-singleton.c
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/controller.c
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/edit.esp
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/list.esp
DEPS_69 += src/paks/esp-html-mvc/templates/esp-html-mvc/start.me
DEPS_69 += src/paks/esp-legacy-mvc
DEPS_69 += src/paks/esp-legacy-mvc/package.json
DEPS_69 += src/paks/esp-legacy-mvc/templates
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/appweb.conf
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/controller.c
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/edit.esp
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/layouts
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/layouts/default.esp
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/list.esp
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/migration.c
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/src
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/src/app.c
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/css
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/css/all.css
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/banner.jpg
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/favicon.ico
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/splash.jpg
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/index.esp
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.esp.js
DEPS_69 += src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.js
DEPS_69 += src/paks/esp-server
DEPS_69 += src/paks/esp-server/package.json
DEPS_69 += src/paks/esp-server/templates
DEPS_69 += src/paks/esp-server/templates/esp-server
DEPS_69 += src/paks/esp-server/templates/esp-server/appweb.conf
DEPS_69 += src/paks/esp-server/templates/esp-server/controller.c
DEPS_69 += src/paks/esp-server/templates/esp-server/migration.c
DEPS_69 += src/paks/esp-server/templates/esp-server/src
DEPS_69 += src/paks/esp-server/templates/esp-server/src/app.c

$(CONFIG)/esp: $(DEPS_69)
	( \
	cd src/paks; \
	mkdir -p "../../$(CONFIG)/esp/esp-angular/4.6.0" ; \
	cp esp-angular/esp-click.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp-click.js ; \
	cp esp-angular/esp-edit.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp-edit.js ; \
	cp esp-angular/esp-field-errors.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp-field-errors.js ; \
	cp esp-angular/esp-fixnum.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp-fixnum.js ; \
	cp esp-angular/esp-format.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp-format.js ; \
	cp esp-angular/esp-input-group.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp-input-group.js ; \
	cp esp-angular/esp-input.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp-input.js ; \
	cp esp-angular/esp-resource.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp-resource.js ; \
	cp esp-angular/esp-session.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp-session.js ; \
	cp esp-angular/esp-titlecase.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp-titlecase.js ; \
	cp esp-angular/esp.js ../../$(CONFIG)/esp/esp-angular/4.6.0/esp.js ; \
	cp esp-angular/package.json ../../$(CONFIG)/esp/esp-angular/4.6.0/package.json ; \
	mkdir -p "../../$(CONFIG)/esp/esp-angular-mvc/4.6.0" ; \
	cp esp-angular-mvc/package.json ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/package.json ; \
	mkdir -p "../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates" ; \
	mkdir -p "../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/appweb.conf ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/appweb.conf ; \
	mkdir -p "../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client" ; \
	mkdir -p "../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/app" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/app/main.js ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/app/main.js ; \
	mkdir -p "../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/assets" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/assets/favicon.ico ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/assets/favicon.ico ; \
	mkdir -p "../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/all.css ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css/all.css ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/all.less ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css/all.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/app.less ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css/app.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/fix.css ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css/fix.css ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/theme.less ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css/theme.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/index.esp ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/index.esp ; \
	mkdir -p "../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/pages" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/pages/splash.html ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/pages/splash.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller-singleton.c ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/controller-singleton.c ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller.c ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/controller.c ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller.js ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/controller.js ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/edit.html ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/edit.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/list.html ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/list.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/model.js ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/model.js ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/start.me ../../$(CONFIG)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/start.me ; \
	mkdir -p "../../$(CONFIG)/esp/esp-html-mvc/4.6.0" ; \
	cp esp-html-mvc/package.json ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/package.json ; \
	mkdir -p "../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates" ; \
	mkdir -p "../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc" ; \
	cp esp-html-mvc/templates/esp-html-mvc/appweb.conf ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/appweb.conf ; \
	mkdir -p "../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client" ; \
	mkdir -p "../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/assets" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/assets/favicon.ico ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/assets/favicon.ico ; \
	mkdir -p "../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/css" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/all.css ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/css/all.css ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/all.less ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/css/all.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/app.less ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/css/app.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/theme.less ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/css/theme.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/index.esp ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/index.esp ; \
	mkdir -p "../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/layouts" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/layouts/default.esp ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/layouts/default.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/controller-singleton.c ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/controller-singleton.c ; \
	cp esp-html-mvc/templates/esp-html-mvc/controller.c ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/controller.c ; \
	cp esp-html-mvc/templates/esp-html-mvc/edit.esp ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/edit.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/list.esp ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/list.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/start.me ../../$(CONFIG)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/start.me ; \
	mkdir -p "../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0" ; \
	cp esp-legacy-mvc/package.json ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/package.json ; \
	mkdir -p "../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates" ; \
	mkdir -p "../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/appweb.conf ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/appweb.conf ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/controller.c ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/controller.c ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/edit.esp ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/edit.esp ; \
	mkdir -p "../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/layouts" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/layouts/default.esp ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/layouts/default.esp ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/list.esp ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/list.esp ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/migration.c ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/migration.c ; \
	mkdir -p "../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/src" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/src/app.c ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/src/app.c ; \
	mkdir -p "../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static" ; \
	mkdir -p "../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/css" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/css/all.css ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/css/all.css ; \
	mkdir -p "../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/images" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/banner.jpg ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/images/banner.jpg ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/favicon.ico ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/images/favicon.ico ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/splash.jpg ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/images/splash.jpg ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/index.esp ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/index.esp ; \
	mkdir -p "../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/js" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.esp.js ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/js/jquery.esp.js ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.js ../../$(CONFIG)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/js/jquery.js ; \
	mkdir -p "../../$(CONFIG)/esp/esp-server/4.6.0" ; \
	cp esp-server/package.json ../../$(CONFIG)/esp/esp-server/4.6.0/package.json ; \
	mkdir -p "../../$(CONFIG)/esp/esp-server/4.6.0/templates" ; \
	mkdir -p "../../$(CONFIG)/esp/esp-server/4.6.0/templates/esp-server" ; \
	cp esp-server/templates/esp-server/appweb.conf ../../$(CONFIG)/esp/esp-server/4.6.0/templates/esp-server/appweb.conf ; \
	cp esp-server/templates/esp-server/controller.c ../../$(CONFIG)/esp/esp-server/4.6.0/templates/esp-server/controller.c ; \
	cp esp-server/templates/esp-server/migration.c ../../$(CONFIG)/esp/esp-server/4.6.0/templates/esp-server/migration.c ; \
	mkdir -p "../../$(CONFIG)/esp/esp-server/4.6.0/templates/esp-server/src" ; \
	cp esp-server/templates/esp-server/src/app.c ../../$(CONFIG)/esp/esp-server/4.6.0/templates/esp-server/src/app.c ; \
	)
endif

ifeq ($(ME_COM_ESP),1)
#
#   esp.conf
#
DEPS_70 += src/paks/esp/esp.conf

$(CONFIG)/bin/esp.conf: $(DEPS_70)
	@echo '      [Copy] $(CONFIG)/bin/esp.conf'
	mkdir -p "$(CONFIG)/bin"
	cp src/paks/esp/esp.conf $(CONFIG)/bin/esp.conf
endif

#
#   esp.o
#
DEPS_71 += $(CONFIG)/inc/me.h
DEPS_71 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/esp.o: \
    src/paks/esp/esp.c $(DEPS_71)
	@echo '   [Compile] $(CONFIG)/obj/esp.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/esp.o $(LDFLAGS) $(IFLAGS) src/paks/esp/esp.c

ifeq ($(ME_COM_ESP),1)
#
#   espcmd
#
DEPS_72 += $(CONFIG)/inc/mpr.h
DEPS_72 += $(CONFIG)/inc/me.h
DEPS_72 += $(CONFIG)/inc/osdep.h
DEPS_72 += $(CONFIG)/obj/mprLib.o
DEPS_72 += $(CONFIG)/bin/libmpr.a
DEPS_72 += $(CONFIG)/inc/pcre.h
DEPS_72 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_72 += $(CONFIG)/bin/libpcre.a
endif
DEPS_72 += $(CONFIG)/inc/http.h
DEPS_72 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_72 += $(CONFIG)/bin/libhttp.a
endif
DEPS_72 += $(CONFIG)/inc/appweb.h
DEPS_72 += $(CONFIG)/inc/customize.h
DEPS_72 += $(CONFIG)/obj/config.o
DEPS_72 += $(CONFIG)/obj/convenience.o
DEPS_72 += $(CONFIG)/obj/dirHandler.o
DEPS_72 += $(CONFIG)/obj/fileHandler.o
DEPS_72 += $(CONFIG)/obj/log.o
DEPS_72 += $(CONFIG)/obj/server.o
DEPS_72 += $(CONFIG)/bin/libappweb.a
DEPS_72 += $(CONFIG)/inc/edi.h
DEPS_72 += $(CONFIG)/inc/esp.h
DEPS_72 += $(CONFIG)/inc/mdb.h
DEPS_72 += $(CONFIG)/obj/edi.o
DEPS_72 += $(CONFIG)/obj/espAbbrev.o
DEPS_72 += $(CONFIG)/obj/espDeprecated.o
DEPS_72 += $(CONFIG)/obj/espFramework.o
DEPS_72 += $(CONFIG)/obj/espHandler.o
DEPS_72 += $(CONFIG)/obj/espHtml.o
DEPS_72 += $(CONFIG)/obj/espTemplate.o
DEPS_72 += $(CONFIG)/obj/mdb.o
DEPS_72 += $(CONFIG)/obj/sdb.o
DEPS_72 += $(CONFIG)/bin/libmod_esp.a
DEPS_72 += $(CONFIG)/obj/esp.o

LIBS_72 += -lmod_esp
LIBS_72 += -lappweb
ifeq ($(ME_COM_HTTP),1)
    LIBS_72 += -lhttp
endif
LIBS_72 += -lmpr
ifeq ($(ME_COM_PCRE),1)
    LIBS_72 += -lpcre
endif
ifeq ($(ME_COM_SQLITE),1)
    LIBS_72 += -lsql
endif

$(CONFIG)/bin/esp: $(DEPS_72)
	@echo '      [Link] $(CONFIG)/bin/esp'
	$(CC) -o $(CONFIG)/bin/esp $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/esp.o" $(LIBPATHS_72) $(LIBS_72) $(LIBS_72) $(LIBS) $(LIBS) 
endif


#
#   genslink
#
genslink: $(DEPS_73)
	( \
	cd src; \
	esp --static --genlink slink.c compile ; \
	)

#
#   http-ca-crt
#
DEPS_74 += src/paks/http/ca.crt

$(CONFIG)/bin/ca.crt: $(DEPS_74)
	@echo '      [Copy] $(CONFIG)/bin/ca.crt'
	mkdir -p "$(CONFIG)/bin"
	cp src/paks/http/ca.crt $(CONFIG)/bin/ca.crt

#
#   http.o
#
DEPS_75 += $(CONFIG)/inc/me.h
DEPS_75 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/http.o: \
    src/paks/http/http.c $(DEPS_75)
	@echo '   [Compile] $(CONFIG)/obj/http.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/http.o $(LDFLAGS) $(IFLAGS) "-I$(ME_COM_OPENSSL_PATH)/include" "-I$(ME_COM_MATRIXSSL_PATH)" "-I$(ME_COM_MATRIXSSL_PATH)/matrixssl" "-I$(ME_COM_NANOSSL_PATH)/src" src/paks/http/http.c

ifeq ($(ME_COM_HTTP),1)
#
#   httpcmd
#
DEPS_76 += $(CONFIG)/inc/mpr.h
DEPS_76 += $(CONFIG)/inc/me.h
DEPS_76 += $(CONFIG)/inc/osdep.h
DEPS_76 += $(CONFIG)/obj/mprLib.o
DEPS_76 += $(CONFIG)/bin/libmpr.a
DEPS_76 += $(CONFIG)/inc/pcre.h
DEPS_76 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_76 += $(CONFIG)/bin/libpcre.a
endif
DEPS_76 += $(CONFIG)/inc/http.h
DEPS_76 += $(CONFIG)/obj/httpLib.o
DEPS_76 += $(CONFIG)/bin/libhttp.a
DEPS_76 += $(CONFIG)/inc/est.h
DEPS_76 += $(CONFIG)/obj/estLib.o
ifeq ($(ME_COM_EST),1)
    DEPS_76 += $(CONFIG)/bin/libest.a
endif
DEPS_76 += $(CONFIG)/obj/mprSsl.o
DEPS_76 += $(CONFIG)/bin/libmprssl.a
DEPS_76 += $(CONFIG)/obj/http.o

LIBS_76 += -lhttp
LIBS_76 += -lmpr
ifeq ($(ME_COM_PCRE),1)
    LIBS_76 += -lpcre
endif
LIBS_76 += -lmprssl
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_76 += -lssl
    LIBPATHS_76 += -L$(ME_COM_OPENSSL_PATH)
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_76 += -lcrypto
    LIBPATHS_76 += -L$(ME_COM_OPENSSL_PATH)
endif
ifeq ($(ME_COM_EST),1)
    LIBS_76 += -lest
endif
ifeq ($(ME_COM_MATRIXSSL),1)
    LIBS_76 += -lmatrixssl
    LIBPATHS_76 += -L$(ME_COM_MATRIXSSL_PATH)
endif
ifeq ($(ME_COM_NANOSSL),1)
    LIBS_76 += -lssls
    LIBPATHS_76 += -L$(ME_COM_NANOSSL_PATH)/bin
endif

$(CONFIG)/bin/http: $(DEPS_76)
	@echo '      [Link] $(CONFIG)/bin/http'
	$(CC) -o $(CONFIG)/bin/http $(LDFLAGS) $(LIBPATHS)    "$(CONFIG)/obj/http.o" $(LIBPATHS_76) $(LIBS_76) $(LIBS_76) $(LIBS) $(LIBS) 
endif

#
#   sqlite3.h
#
$(CONFIG)/inc/sqlite3.h: $(DEPS_77)
	@echo '      [Copy] $(CONFIG)/inc/sqlite3.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/sqlite/sqlite3.h $(CONFIG)/inc/sqlite3.h

#
#   sqlite3.o
#
DEPS_78 += $(CONFIG)/inc/me.h
DEPS_78 += $(CONFIG)/inc/sqlite3.h

$(CONFIG)/obj/sqlite3.o: \
    src/paks/sqlite/sqlite3.c $(DEPS_78)
	@echo '   [Compile] $(CONFIG)/obj/sqlite3.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/sqlite3.o $(LDFLAGS) $(IFLAGS) src/paks/sqlite/sqlite3.c

ifeq ($(ME_COM_SQLITE),1)
#
#   libsql
#
DEPS_79 += $(CONFIG)/inc/sqlite3.h
DEPS_79 += $(CONFIG)/inc/me.h
DEPS_79 += $(CONFIG)/obj/sqlite3.o

$(CONFIG)/bin/libsql.a: $(DEPS_79)
	@echo '      [Link] $(CONFIG)/bin/libsql.a'
	ar -cr $(CONFIG)/bin/libsql.a "$(CONFIG)/obj/sqlite3.o"
endif

#
#   manager.o
#
DEPS_80 += $(CONFIG)/inc/me.h
DEPS_80 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/manager.o: \
    src/paks/mpr/manager.c $(DEPS_80)
	@echo '   [Compile] $(CONFIG)/obj/manager.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/manager.o $(LDFLAGS) $(IFLAGS) src/paks/mpr/manager.c

#
#   manager
#
DEPS_81 += $(CONFIG)/inc/mpr.h
DEPS_81 += $(CONFIG)/inc/me.h
DEPS_81 += $(CONFIG)/inc/osdep.h
DEPS_81 += $(CONFIG)/obj/mprLib.o
DEPS_81 += $(CONFIG)/bin/libmpr.a
DEPS_81 += $(CONFIG)/obj/manager.o

LIBS_81 += -lmpr

$(CONFIG)/bin/appman: $(DEPS_81)
	@echo '      [Link] $(CONFIG)/bin/appman'
	$(CC) -o $(CONFIG)/bin/appman $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/manager.o" $(LIBPATHS_81) $(LIBS_81) $(LIBS_81) $(LIBS) $(LIBS) 

#
#   server-cache
#
src/server/cache: $(DEPS_82)
	( \
	cd src/server; \
	mkdir -p cache ; \
	)

#
#   sqlite.o
#
DEPS_83 += $(CONFIG)/inc/me.h
DEPS_83 += $(CONFIG)/inc/sqlite3.h

$(CONFIG)/obj/sqlite.o: \
    src/paks/sqlite/sqlite.c $(DEPS_83)
	@echo '   [Compile] $(CONFIG)/obj/sqlite.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/sqlite.o $(LDFLAGS) $(IFLAGS) src/paks/sqlite/sqlite.c

ifeq ($(ME_COM_SQLITE),1)
#
#   sqliteshell
#
DEPS_84 += $(CONFIG)/inc/sqlite3.h
DEPS_84 += $(CONFIG)/inc/me.h
DEPS_84 += $(CONFIG)/obj/sqlite3.o
DEPS_84 += $(CONFIG)/bin/libsql.a
DEPS_84 += $(CONFIG)/obj/sqlite.o

LIBS_84 += -lsql

$(CONFIG)/bin/sqlite: $(DEPS_84)
	@echo '      [Link] $(CONFIG)/bin/sqlite'
	$(CC) -o $(CONFIG)/bin/sqlite $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/sqlite.o" $(LIBPATHS_84) $(LIBS_84) $(LIBS_84) $(LIBS) $(LIBS) 
endif

#
#   testAppweb.h
#
$(CONFIG)/inc/testAppweb.h: $(DEPS_85)
	@echo '      [Copy] $(CONFIG)/inc/testAppweb.h'
	mkdir -p "$(CONFIG)/inc"
	cp test/src/testAppweb.h $(CONFIG)/inc/testAppweb.h

#
#   testAppweb.o
#
DEPS_86 += $(CONFIG)/inc/me.h
DEPS_86 += $(CONFIG)/inc/testAppweb.h
DEPS_86 += $(CONFIG)/inc/mpr.h
DEPS_86 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/testAppweb.o: \
    test/src/testAppweb.c $(DEPS_86)
	@echo '   [Compile] $(CONFIG)/obj/testAppweb.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/testAppweb.o $(LDFLAGS) $(IFLAGS) test/src/testAppweb.c

#
#   testHttp.o
#
DEPS_87 += $(CONFIG)/inc/me.h
DEPS_87 += $(CONFIG)/inc/testAppweb.h

$(CONFIG)/obj/testHttp.o: \
    test/src/testHttp.c $(DEPS_87)
	@echo '   [Compile] $(CONFIG)/obj/testHttp.o'
	$(CC) -c $(DFLAGS) -o $(CONFIG)/obj/testHttp.o $(LDFLAGS) $(IFLAGS) test/src/testHttp.c

#
#   testAppweb
#
DEPS_88 += $(CONFIG)/inc/mpr.h
DEPS_88 += $(CONFIG)/inc/me.h
DEPS_88 += $(CONFIG)/inc/osdep.h
DEPS_88 += $(CONFIG)/obj/mprLib.o
DEPS_88 += $(CONFIG)/bin/libmpr.a
DEPS_88 += $(CONFIG)/inc/pcre.h
DEPS_88 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_88 += $(CONFIG)/bin/libpcre.a
endif
DEPS_88 += $(CONFIG)/inc/http.h
DEPS_88 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_88 += $(CONFIG)/bin/libhttp.a
endif
DEPS_88 += $(CONFIG)/inc/appweb.h
DEPS_88 += $(CONFIG)/inc/customize.h
DEPS_88 += $(CONFIG)/obj/config.o
DEPS_88 += $(CONFIG)/obj/convenience.o
DEPS_88 += $(CONFIG)/obj/dirHandler.o
DEPS_88 += $(CONFIG)/obj/fileHandler.o
DEPS_88 += $(CONFIG)/obj/log.o
DEPS_88 += $(CONFIG)/obj/server.o
DEPS_88 += $(CONFIG)/bin/libappweb.a
DEPS_88 += $(CONFIG)/inc/testAppweb.h
DEPS_88 += $(CONFIG)/obj/testAppweb.o
DEPS_88 += $(CONFIG)/obj/testHttp.o

LIBS_88 += -lappweb
ifeq ($(ME_COM_HTTP),1)
    LIBS_88 += -lhttp
endif
LIBS_88 += -lmpr
ifeq ($(ME_COM_PCRE),1)
    LIBS_88 += -lpcre
endif

$(CONFIG)/bin/testAppweb: $(DEPS_88)
	@echo '      [Link] $(CONFIG)/bin/testAppweb'
	$(CC) -o $(CONFIG)/bin/testAppweb $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/testAppweb.o" "$(CONFIG)/obj/testHttp.o" $(LIBPATHS_88) $(LIBS_88) $(LIBS_88) $(LIBS) $(LIBS) 

ifeq ($(ME_COM_CGI),1)
#
#   test-basic.cgi
#
DEPS_89 += $(CONFIG)/inc/mpr.h
DEPS_89 += $(CONFIG)/inc/me.h
DEPS_89 += $(CONFIG)/inc/osdep.h
DEPS_89 += $(CONFIG)/obj/mprLib.o
DEPS_89 += $(CONFIG)/bin/libmpr.a
DEPS_89 += $(CONFIG)/inc/pcre.h
DEPS_89 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_89 += $(CONFIG)/bin/libpcre.a
endif
DEPS_89 += $(CONFIG)/inc/http.h
DEPS_89 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_89 += $(CONFIG)/bin/libhttp.a
endif
DEPS_89 += $(CONFIG)/inc/appweb.h
DEPS_89 += $(CONFIG)/inc/customize.h
DEPS_89 += $(CONFIG)/obj/config.o
DEPS_89 += $(CONFIG)/obj/convenience.o
DEPS_89 += $(CONFIG)/obj/dirHandler.o
DEPS_89 += $(CONFIG)/obj/fileHandler.o
DEPS_89 += $(CONFIG)/obj/log.o
DEPS_89 += $(CONFIG)/obj/server.o
DEPS_89 += $(CONFIG)/bin/libappweb.a
DEPS_89 += $(CONFIG)/inc/testAppweb.h
DEPS_89 += $(CONFIG)/obj/testAppweb.o
DEPS_89 += $(CONFIG)/obj/testHttp.o
DEPS_89 += $(CONFIG)/bin/testAppweb

test/web/auth/basic/basic.cgi: $(DEPS_89)
	( \
	cd test; \
	echo "#!`type -p ejs`" >web/auth/basic/basic.cgi ; \
	echo 'print("HTTP/1.0 200 OK\nContent-Type: text/plain\n\n" + serialize(App.env, {pretty: true}) + "\n")' >>web/auth/basic/basic.cgi ; \
	chmod +x web/auth/basic/basic.cgi ; \
	)
endif

ifeq ($(ME_COM_CGI),1)
#
#   test-cache.cgi
#
DEPS_90 += $(CONFIG)/inc/mpr.h
DEPS_90 += $(CONFIG)/inc/me.h
DEPS_90 += $(CONFIG)/inc/osdep.h
DEPS_90 += $(CONFIG)/obj/mprLib.o
DEPS_90 += $(CONFIG)/bin/libmpr.a
DEPS_90 += $(CONFIG)/inc/pcre.h
DEPS_90 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_90 += $(CONFIG)/bin/libpcre.a
endif
DEPS_90 += $(CONFIG)/inc/http.h
DEPS_90 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_90 += $(CONFIG)/bin/libhttp.a
endif
DEPS_90 += $(CONFIG)/inc/appweb.h
DEPS_90 += $(CONFIG)/inc/customize.h
DEPS_90 += $(CONFIG)/obj/config.o
DEPS_90 += $(CONFIG)/obj/convenience.o
DEPS_90 += $(CONFIG)/obj/dirHandler.o
DEPS_90 += $(CONFIG)/obj/fileHandler.o
DEPS_90 += $(CONFIG)/obj/log.o
DEPS_90 += $(CONFIG)/obj/server.o
DEPS_90 += $(CONFIG)/bin/libappweb.a
DEPS_90 += $(CONFIG)/inc/testAppweb.h
DEPS_90 += $(CONFIG)/obj/testAppweb.o
DEPS_90 += $(CONFIG)/obj/testHttp.o
DEPS_90 += $(CONFIG)/bin/testAppweb

test/web/caching/cache.cgi: $(DEPS_90)
	( \
	cd test; \
	echo "#!`type -p ejs`" >web/caching/cache.cgi ; \
	echo 'print("HTTP/1.0 200 OK\nContent-Type: text/plain\n\n{number:" + Date().now() + "}\n")' >>web/caching/cache.cgi ; \
	chmod +x web/caching/cache.cgi ; \
	)
endif

ifeq ($(ME_COM_CGI),1)
#
#   test-cgiProgram
#
DEPS_91 += $(CONFIG)/inc/me.h
DEPS_91 += $(CONFIG)/obj/cgiProgram.o
DEPS_91 += $(CONFIG)/bin/cgiProgram

test/cgi-bin/cgiProgram: $(DEPS_91)
	( \
	cd test; \
	cp ../$(CONFIG)/bin/cgiProgram cgi-bin/cgiProgram ; \
	cp ../$(CONFIG)/bin/cgiProgram cgi-bin/nph-cgiProgram ; \
	cp ../$(CONFIG)/bin/cgiProgram 'cgi-bin/cgi Program' ; \
	cp ../$(CONFIG)/bin/cgiProgram web/cgiProgram.cgi ; \
	chmod +x cgi-bin/* web/cgiProgram.cgi ; \
	)
endif

ifeq ($(ME_COM_CGI),1)
#
#   test-testScript
#
DEPS_92 += $(CONFIG)/inc/mpr.h
DEPS_92 += $(CONFIG)/inc/me.h
DEPS_92 += $(CONFIG)/inc/osdep.h
DEPS_92 += $(CONFIG)/obj/mprLib.o
DEPS_92 += $(CONFIG)/bin/libmpr.a
DEPS_92 += $(CONFIG)/inc/pcre.h
DEPS_92 += $(CONFIG)/obj/pcre.o
ifeq ($(ME_COM_PCRE),1)
    DEPS_92 += $(CONFIG)/bin/libpcre.a
endif
DEPS_92 += $(CONFIG)/inc/http.h
DEPS_92 += $(CONFIG)/obj/httpLib.o
ifeq ($(ME_COM_HTTP),1)
    DEPS_92 += $(CONFIG)/bin/libhttp.a
endif
DEPS_92 += $(CONFIG)/inc/appweb.h
DEPS_92 += $(CONFIG)/inc/customize.h
DEPS_92 += $(CONFIG)/obj/config.o
DEPS_92 += $(CONFIG)/obj/convenience.o
DEPS_92 += $(CONFIG)/obj/dirHandler.o
DEPS_92 += $(CONFIG)/obj/fileHandler.o
DEPS_92 += $(CONFIG)/obj/log.o
DEPS_92 += $(CONFIG)/obj/server.o
DEPS_92 += $(CONFIG)/bin/libappweb.a
DEPS_92 += $(CONFIG)/inc/testAppweb.h
DEPS_92 += $(CONFIG)/obj/testAppweb.o
DEPS_92 += $(CONFIG)/obj/testHttp.o
DEPS_92 += $(CONFIG)/bin/testAppweb

test/cgi-bin/testScript: $(DEPS_92)
	( \
	cd test; \
	echo '#!../$(CONFIG)/bin/cgiProgram' >cgi-bin/testScript ; chmod +x cgi-bin/testScript ; \
	)
endif


#
#   stop
#
DEPS_93 += compile

stop: $(DEPS_93)
	( \
	cd .; \
	@./$(CONFIG)/bin/appman stop disable uninstall >/dev/null 2>&1 ; true ; \
	)

#
#   installBinary
#
installBinary: $(DEPS_94)
	( \
	cd .; \
	mkdir -p "$(ME_APP_PREFIX)" ; \
	rm -f "$(ME_APP_PREFIX)/latest" ; \
	ln -s "4.6.0" "$(ME_APP_PREFIX)/latest" ; \
	mkdir -p "$(ME_LOG_PREFIX)" ; \
	chmod 755 "$(ME_LOG_PREFIX)" ; \
	[ `id -u` = 0 ] && chown $(WEB_USER):$(WEB_GROUP) "$(ME_LOG_PREFIX)"; true ; \
	mkdir -p "$(ME_CACHE_PREFIX)" ; \
	chmod 755 "$(ME_CACHE_PREFIX)" ; \
	[ `id -u` = 0 ] && chown $(WEB_USER):$(WEB_GROUP) "$(ME_CACHE_PREFIX)"; true ; \
	mkdir -p "$(ME_VAPP_PREFIX)/bin" ; \
	cp $(CONFIG)/bin/appweb $(ME_VAPP_PREFIX)/bin/appweb ; \
	mkdir -p "$(ME_BIN_PREFIX)" ; \
	rm -f "$(ME_BIN_PREFIX)/appweb" ; \
	ln -s "$(ME_VAPP_PREFIX)/bin/appweb" "$(ME_BIN_PREFIX)/appweb" ; \
	cp $(CONFIG)/bin/appman $(ME_VAPP_PREFIX)/bin/appman ; \
	rm -f "$(ME_BIN_PREFIX)/appman" ; \
	ln -s "$(ME_VAPP_PREFIX)/bin/appman" "$(ME_BIN_PREFIX)/appman" ; \
	cp $(CONFIG)/bin/http $(ME_VAPP_PREFIX)/bin/http ; \
	rm -f "$(ME_BIN_PREFIX)/http" ; \
	ln -s "$(ME_VAPP_PREFIX)/bin/http" "$(ME_BIN_PREFIX)/http" ; \
	if [ "$(ME_COM_ESP)" = 1 ]; then true ; \
	cp $(CONFIG)/bin/esp $(ME_VAPP_PREFIX)/bin/appesp ; \
	rm -f "$(ME_BIN_PREFIX)/appesp" ; \
	ln -s "$(ME_VAPP_PREFIX)/bin/appesp" "$(ME_BIN_PREFIX)/appesp" ; \
	fi ; \
	if [ "$(ME_COM_SSL)" = 1 ]; then true ; \
	cp src/paks/est/ca.crt $(ME_VAPP_PREFIX)/bin/ca.crt ; \
	fi ; \
	if [ "$(ME_COM_OPENSSL)" = 1 ]; then true ; \
	cp $(CONFIG)/bin/libssl*.so* $(ME_VAPP_PREFIX)/bin/libssl*.so* ; \
	cp $(CONFIG)/bin/libcrypto*.so* $(ME_VAPP_PREFIX)/bin/libcrypto*.so* ; \
	fi ; \
	if [ "$(ME_COM_PHP)" = 1 ]; then true ; \
	cp $(CONFIG)/bin/libphp5.so $(ME_VAPP_PREFIX)/bin/libphp5.so ; \
	fi ; \
	if [ "$(ME_COM_ESP)" = 1 ]; then true ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/angular/1.2.6" ; \
	cp src/paks/angular/angular-animate.js $(ME_VAPP_PREFIX)/esp/angular/1.2.6/angular-animate.js ; \
	cp src/paks/angular/angular-csp.css $(ME_VAPP_PREFIX)/esp/angular/1.2.6/angular-csp.css ; \
	cp src/paks/angular/angular-route.js $(ME_VAPP_PREFIX)/esp/angular/1.2.6/angular-route.js ; \
	cp src/paks/angular/angular.js $(ME_VAPP_PREFIX)/esp/angular/1.2.6/angular.js ; \
	cp src/paks/angular/package.json $(ME_VAPP_PREFIX)/esp/angular/1.2.6/package.json ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0" ; \
	cp src/paks/esp-angular/esp-click.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp-click.js ; \
	cp src/paks/esp-angular/esp-edit.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp-edit.js ; \
	cp src/paks/esp-angular/esp-field-errors.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp-field-errors.js ; \
	cp src/paks/esp-angular/esp-fixnum.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp-fixnum.js ; \
	cp src/paks/esp-angular/esp-format.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp-format.js ; \
	cp src/paks/esp-angular/esp-input-group.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp-input-group.js ; \
	cp src/paks/esp-angular/esp-input.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp-input.js ; \
	cp src/paks/esp-angular/esp-resource.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp-resource.js ; \
	cp src/paks/esp-angular/esp-session.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp-session.js ; \
	cp src/paks/esp-angular/esp-titlecase.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp-titlecase.js ; \
	cp src/paks/esp-angular/esp.js $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/esp.js ; \
	cp src/paks/esp-angular/package.json $(ME_VAPP_PREFIX)/esp/esp-angular/4.6.0/package.json ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0" ; \
	cp src/paks/esp-angular-mvc/package.json $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/package.json ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates" ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc" ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/appweb.conf $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/appweb.conf ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client" ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/app" ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/app/main.js $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/app/main.js ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/assets" ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/assets/favicon.ico $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/assets/favicon.ico ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css" ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/all.css $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css/all.css ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/all.less $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css/all.less ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/app.less $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css/app.less ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/fix.css $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css/fix.css ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/theme.less $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/css/theme.less ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/index.esp $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/index.esp ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/pages" ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/client/pages/splash.html $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/client/pages/splash.html ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/controller-singleton.c $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/controller-singleton.c ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/controller.c $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/controller.c ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/controller.js $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/controller.js ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/edit.html $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/edit.html ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/list.html $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/list.html ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/model.js $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/model.js ; \
	cp src/paks/esp-angular-mvc/templates/esp-angular-mvc/start.me $(ME_VAPP_PREFIX)/esp/esp-angular-mvc/4.6.0/templates/esp-angular-mvc/start.me ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0" ; \
	cp src/paks/esp-html-mvc/package.json $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/package.json ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates" ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc" ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/appweb.conf $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/appweb.conf ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client" ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/assets" ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/client/assets/favicon.ico $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/assets/favicon.ico ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/css" ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/all.css $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/css/all.css ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/all.less $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/css/all.less ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/app.less $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/css/app.less ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/client/css/theme.less $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/css/theme.less ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/client/index.esp $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/index.esp ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/layouts" ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/client/layouts/default.esp $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/client/layouts/default.esp ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/controller-singleton.c $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/controller-singleton.c ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/controller.c $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/controller.c ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/edit.esp $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/edit.esp ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/list.esp $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/list.esp ; \
	cp src/paks/esp-html-mvc/templates/esp-html-mvc/start.me $(ME_VAPP_PREFIX)/esp/esp-html-mvc/4.6.0/templates/esp-html-mvc/start.me ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0" ; \
	cp src/paks/esp-legacy-mvc/package.json $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/package.json ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates" ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc" ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/appweb.conf $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/appweb.conf ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/controller.c $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/controller.c ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/edit.esp $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/edit.esp ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/layouts" ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/layouts/default.esp $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/layouts/default.esp ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/list.esp $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/list.esp ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/migration.c $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/migration.c ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/src" ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/src/app.c $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/src/app.c ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static" ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/css" ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/css/all.css $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/css/all.css ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/images" ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/banner.jpg $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/images/banner.jpg ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/favicon.ico $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/images/favicon.ico ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/splash.jpg $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/images/splash.jpg ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/index.esp $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/index.esp ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/js" ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.esp.js $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/js/jquery.esp.js ; \
	cp src/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.js $(ME_VAPP_PREFIX)/esp/esp-legacy-mvc/4.6.0/templates/esp-legacy-mvc/static/js/jquery.js ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-server/4.6.0" ; \
	cp src/paks/esp-server/package.json $(ME_VAPP_PREFIX)/esp/esp-server/4.6.0/package.json ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-server/4.6.0/templates" ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-server/4.6.0/templates/esp-server" ; \
	cp src/paks/esp-server/templates/esp-server/appweb.conf $(ME_VAPP_PREFIX)/esp/esp-server/4.6.0/templates/esp-server/appweb.conf ; \
	cp src/paks/esp-server/templates/esp-server/controller.c $(ME_VAPP_PREFIX)/esp/esp-server/4.6.0/templates/esp-server/controller.c ; \
	cp src/paks/esp-server/templates/esp-server/migration.c $(ME_VAPP_PREFIX)/esp/esp-server/4.6.0/templates/esp-server/migration.c ; \
	mkdir -p "$(ME_VAPP_PREFIX)/esp/esp-server/4.6.0/templates/esp-server/src" ; \
	cp src/paks/esp-server/templates/esp-server/src/app.c $(ME_VAPP_PREFIX)/esp/esp-server/4.6.0/templates/esp-server/src/app.c ; \
	fi ; \
	if [ "$(ME_COM_ESP)" = 1 ]; then true ; \
	cp $(CONFIG)/bin/esp.conf $(ME_VAPP_PREFIX)/bin/esp.conf ; \
	fi ; \
	mkdir -p "$(ME_WEB_PREFIX)/bench" ; \
	cp src/server/web/bench/1b.html $(ME_WEB_PREFIX)/bench/1b.html ; \
	cp src/server/web/bench/4k.html $(ME_WEB_PREFIX)/bench/4k.html ; \
	cp src/server/web/bench/64k.html $(ME_WEB_PREFIX)/bench/64k.html ; \
	mkdir -p "$(ME_WEB_PREFIX)" ; \
	cp src/server/web/favicon.ico $(ME_WEB_PREFIX)/favicon.ico ; \
	mkdir -p "$(ME_WEB_PREFIX)/icons" ; \
	cp src/server/web/icons/back.gif $(ME_WEB_PREFIX)/icons/back.gif ; \
	cp src/server/web/icons/blank.gif $(ME_WEB_PREFIX)/icons/blank.gif ; \
	cp src/server/web/icons/compressed.gif $(ME_WEB_PREFIX)/icons/compressed.gif ; \
	cp src/server/web/icons/folder.gif $(ME_WEB_PREFIX)/icons/folder.gif ; \
	cp src/server/web/icons/parent.gif $(ME_WEB_PREFIX)/icons/parent.gif ; \
	cp src/server/web/icons/space.gif $(ME_WEB_PREFIX)/icons/space.gif ; \
	cp src/server/web/icons/text.gif $(ME_WEB_PREFIX)/icons/text.gif ; \
	cp src/server/web/iehacks.css $(ME_WEB_PREFIX)/iehacks.css ; \
	mkdir -p "$(ME_WEB_PREFIX)/images" ; \
	cp src/server/web/images/banner.jpg $(ME_WEB_PREFIX)/images/banner.jpg ; \
	cp src/server/web/images/bottomShadow.jpg $(ME_WEB_PREFIX)/images/bottomShadow.jpg ; \
	cp src/server/web/images/shadow.jpg $(ME_WEB_PREFIX)/images/shadow.jpg ; \
	cp src/server/web/index.html $(ME_WEB_PREFIX)/index.html ; \
	cp src/server/web/min-index.html $(ME_WEB_PREFIX)/min-index.html ; \
	cp src/server/web/print.css $(ME_WEB_PREFIX)/print.css ; \
	cp src/server/web/screen.css $(ME_WEB_PREFIX)/screen.css ; \
	mkdir -p "$(ME_WEB_PREFIX)/test" ; \
	cp src/server/web/test/bench.html $(ME_WEB_PREFIX)/test/bench.html ; \
	cp src/server/web/test/test.cgi $(ME_WEB_PREFIX)/test/test.cgi ; \
	cp src/server/web/test/test.ejs $(ME_WEB_PREFIX)/test/test.ejs ; \
	cp src/server/web/test/test.esp $(ME_WEB_PREFIX)/test/test.esp ; \
	cp src/server/web/test/test.html $(ME_WEB_PREFIX)/test/test.html ; \
	cp src/server/web/test/test.php $(ME_WEB_PREFIX)/test/test.php ; \
	cp src/server/web/test/test.pl $(ME_WEB_PREFIX)/test/test.pl ; \
	cp src/server/web/test/test.py $(ME_WEB_PREFIX)/test/test.py ; \
	mkdir -p "$(ME_WEB_PREFIX)/test" ; \
	cp src/server/web/test/test.cgi $(ME_WEB_PREFIX)/test/test.cgi ; \
	chmod 755 "$(ME_WEB_PREFIX)/test/test.cgi" ; \
	cp src/server/web/test/test.pl $(ME_WEB_PREFIX)/test/test.pl ; \
	chmod 755 "$(ME_WEB_PREFIX)/test/test.pl" ; \
	cp src/server/web/test/test.py $(ME_WEB_PREFIX)/test/test.py ; \
	chmod 755 "$(ME_WEB_PREFIX)/test/test.py" ; \
	mkdir -p "$(ME_ETC_PREFIX)" ; \
	cp src/server/mime.types $(ME_ETC_PREFIX)/mime.types ; \
	cp src/server/self.crt $(ME_ETC_PREFIX)/self.crt ; \
	cp src/server/self.key $(ME_ETC_PREFIX)/self.key ; \
	if [ "$(ME_COM_PHP)" = 1 ]; then true ; \
	cp src/server/php.ini $(ME_ETC_PREFIX)/php.ini ; \
	fi ; \
	cp src/server/appweb.conf $(ME_ETC_PREFIX)/appweb.conf ; \
	cp src/server/sample.conf $(ME_ETC_PREFIX)/sample.conf ; \
	cp src/server/self.crt $(ME_ETC_PREFIX)/self.crt ; \
	cp src/server/self.key $(ME_ETC_PREFIX)/self.key ; \
	echo 'set LOG_DIR "$(ME_LOG_PREFIX)"\nset CACHE_DIR "$(ME_CACHE_PREFIX)"\nDocuments "$(ME_WEB_PREFIX)\nListen 80\n<if SSL_MODULE>\nListenSecure 443\n</if>\n' >$(ME_ETC_PREFIX)/install.conf ; \
	mkdir -p "$(ME_VAPP_PREFIX)/inc" ; \
	cp $(CONFIG)/inc/me.h $(ME_VAPP_PREFIX)/inc/me.h ; \
	mkdir -p "$(ME_INC_PREFIX)/appweb" ; \
	rm -f "$(ME_INC_PREFIX)/appweb/me.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/me.h" "$(ME_INC_PREFIX)/appweb/me.h" ; \
	cp src/paks/osdep/osdep.h $(ME_VAPP_PREFIX)/inc/osdep.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/osdep.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/osdep.h" "$(ME_INC_PREFIX)/appweb/osdep.h" ; \
	cp src/appweb.h $(ME_VAPP_PREFIX)/inc/appweb.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/appweb.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/appweb.h" "$(ME_INC_PREFIX)/appweb/appweb.h" ; \
	cp src/customize.h $(ME_VAPP_PREFIX)/inc/customize.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/customize.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/customize.h" "$(ME_INC_PREFIX)/appweb/customize.h" ; \
	cp src/paks/est/est.h $(ME_VAPP_PREFIX)/inc/est.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/est.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/est.h" "$(ME_INC_PREFIX)/appweb/est.h" ; \
	cp src/paks/http/http.h $(ME_VAPP_PREFIX)/inc/http.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/http.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/http.h" "$(ME_INC_PREFIX)/appweb/http.h" ; \
	cp src/paks/mpr/mpr.h $(ME_VAPP_PREFIX)/inc/mpr.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/mpr.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/mpr.h" "$(ME_INC_PREFIX)/appweb/mpr.h" ; \
	cp src/paks/pcre/pcre.h $(ME_VAPP_PREFIX)/inc/pcre.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/pcre.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/pcre.h" "$(ME_INC_PREFIX)/appweb/pcre.h" ; \
	cp src/paks/sqlite/sqlite3.h $(ME_VAPP_PREFIX)/inc/sqlite3.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/sqlite3.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/sqlite3.h" "$(ME_INC_PREFIX)/appweb/sqlite3.h" ; \
	if [ "$(ME_COM_ESP)" = 1 ]; then true ; \
	cp src/paks/esp/esp.h $(ME_VAPP_PREFIX)/inc/esp.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/esp.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/esp.h" "$(ME_INC_PREFIX)/appweb/esp.h" ; \
	fi ; \
	if [ "$(ME_COM_EJS)" = 1 ]; then true ; \
	cp src/paks/ejs/ejs.h $(ME_VAPP_PREFIX)/inc/ejs.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/ejs.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/ejs.h" "$(ME_INC_PREFIX)/appweb/ejs.h" ; \
	cp src/paks/ejs/ejs.slots.h $(ME_VAPP_PREFIX)/inc/ejs.slots.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/ejs.slots.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/ejs.slots.h" "$(ME_INC_PREFIX)/appweb/ejs.slots.h" ; \
	cp src/paks/ejs/ejsByteGoto.h $(ME_VAPP_PREFIX)/inc/ejsByteGoto.h ; \
	rm -f "$(ME_INC_PREFIX)/appweb/ejsByteGoto.h" ; \
	ln -s "$(ME_VAPP_PREFIX)/inc/ejsByteGoto.h" "$(ME_INC_PREFIX)/appweb/ejsByteGoto.h" ; \
	fi ; \
	if [ "$(ME_COM_EJS)" = 1 ]; then true ; \
	cp $(CONFIG)/bin/ejs.mod $(ME_VAPP_PREFIX)/bin/ejs.mod ; \
	fi ; \
	mkdir -p "$(ME_VAPP_PREFIX)/doc/man1" ; \
	cp doc/man/appman.1 $(ME_VAPP_PREFIX)/doc/man1/appman.1 ; \
	mkdir -p "$(ME_MAN_PREFIX)/man1" ; \
	rm -f "$(ME_MAN_PREFIX)/man1/appman.1" ; \
	ln -s "$(ME_VAPP_PREFIX)/doc/man1/appman.1" "$(ME_MAN_PREFIX)/man1/appman.1" ; \
	cp doc/man/appweb.1 $(ME_VAPP_PREFIX)/doc/man1/appweb.1 ; \
	rm -f "$(ME_MAN_PREFIX)/man1/appweb.1" ; \
	ln -s "$(ME_VAPP_PREFIX)/doc/man1/appweb.1" "$(ME_MAN_PREFIX)/man1/appweb.1" ; \
	cp doc/man/appwebMonitor.1 $(ME_VAPP_PREFIX)/doc/man1/appwebMonitor.1 ; \
	rm -f "$(ME_MAN_PREFIX)/man1/appwebMonitor.1" ; \
	ln -s "$(ME_VAPP_PREFIX)/doc/man1/appwebMonitor.1" "$(ME_MAN_PREFIX)/man1/appwebMonitor.1" ; \
	cp doc/man/authpass.1 $(ME_VAPP_PREFIX)/doc/man1/authpass.1 ; \
	rm -f "$(ME_MAN_PREFIX)/man1/authpass.1" ; \
	ln -s "$(ME_VAPP_PREFIX)/doc/man1/authpass.1" "$(ME_MAN_PREFIX)/man1/authpass.1" ; \
	cp doc/man/esp.1 $(ME_VAPP_PREFIX)/doc/man1/esp.1 ; \
	rm -f "$(ME_MAN_PREFIX)/man1/esp.1" ; \
	ln -s "$(ME_VAPP_PREFIX)/doc/man1/esp.1" "$(ME_MAN_PREFIX)/man1/esp.1" ; \
	cp doc/man/http.1 $(ME_VAPP_PREFIX)/doc/man1/http.1 ; \
	rm -f "$(ME_MAN_PREFIX)/man1/http.1" ; \
	ln -s "$(ME_VAPP_PREFIX)/doc/man1/http.1" "$(ME_MAN_PREFIX)/man1/http.1" ; \
	cp doc/man/makerom.1 $(ME_VAPP_PREFIX)/doc/man1/makerom.1 ; \
	rm -f "$(ME_MAN_PREFIX)/man1/makerom.1" ; \
	ln -s "$(ME_VAPP_PREFIX)/doc/man1/makerom.1" "$(ME_MAN_PREFIX)/man1/makerom.1" ; \
	cp doc/man/manager.1 $(ME_VAPP_PREFIX)/doc/man1/manager.1 ; \
	rm -f "$(ME_MAN_PREFIX)/man1/manager.1" ; \
	ln -s "$(ME_VAPP_PREFIX)/doc/man1/manager.1" "$(ME_MAN_PREFIX)/man1/manager.1" ; \
	)

#
#   start
#
DEPS_95 += compile
DEPS_95 += stop

start: $(DEPS_95)
	( \
	cd .; \
	./$(CONFIG)/bin/appman install enable start ; \
	)

#
#   install
#
DEPS_96 += compile
DEPS_96 += stop
DEPS_96 += installBinary
DEPS_96 += start

install: $(DEPS_96)

#
#   run
#
DEPS_97 += compile

run: $(DEPS_97)
	( \
	cd src/server; \
	sudo ../../$(CONFIG)/bin/appweb -v ; \
	)


#
#   uninstall
#
DEPS_98 += build
DEPS_98 += compile
DEPS_98 += stop

uninstall: $(DEPS_98)
	( \
	cd package; \
	rm -f "$(ME_ETC_PREFIX)/appweb.conf" ; \
	rm -f "$(ME_ETC_PREFIX)/esp.conf" ; \
	rm -f "$(ME_ETC_PREFIX)/mine.types" ; \
	rm -f "$(ME_ETC_PREFIX)/install.conf" ; \
	rm -fr "$(ME_INC_PREFIX)/appweb" ; \
	rm -fr "$(ME_WEB_PREFIX)" ; \
	rm -fr "$(ME_SPOOL_PREFIX)" ; \
	rm -fr "$(ME_CACHE_PREFIX)" ; \
	rm -fr "$(ME_LOG_PREFIX)" ; \
	rm -fr "$(ME_VAPP_PREFIX)" ; \
	rmdir -p "$(ME_ETC_PREFIX)" 2>/dev/null ; true ; \
	rmdir -p "$(ME_WEB_PREFIX)" 2>/dev/null ; true ; \
	rmdir -p "$(ME_LOG_PREFIX)" 2>/dev/null ; true ; \
	rmdir -p "$(ME_SPOOL_PREFIX)" 2>/dev/null ; true ; \
	rmdir -p "$(ME_CACHE_PREFIX)" 2>/dev/null ; true ; \
	rm -f "$(ME_APP_PREFIX)/latest" ; \
	rmdir -p "$(ME_APP_PREFIX)" 2>/dev/null ; true ; \
	)

#
#   version
#
version: $(DEPS_99)
	echo 4.6.0

