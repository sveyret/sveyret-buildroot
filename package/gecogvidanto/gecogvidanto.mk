################################################################################
#
# gecogvidanto
#
################################################################################

GECOGVIDANTO_VERSION = v2.1.1
GECOGVIDANTO_SOURCE = gecogvidanto-$(GECOGVIDANTO_VERSION).tar.gz
GECOGVIDANTO_SITE = https://git.duniter.org/gecogvidanto/gecogvidanto/-/archive/$(GECOGVIDANTO_VERSION)
GECOGVIDANTO_LICENSE = GPL-3
GECOGVIDANTO_LICENSE_FILES = COPYING
GECOGVIDANTO_DEPENDENCIES = host-nodejs

GECOGVIDANTO_PLUGINS = @gecogvidanto/plugin-nedb @gecogvidanto/plugin-basesys
ifeq ($(BR2_PACKAGE_GECOGVIDANTO_BARTER),y)
GECOGVIDANTO_PLUGINS += @gecogvidanto/plugin-barter
endif
ifeq ($(BR2_PACKAGE_GECOGVIDANTO_MUTCREDIT),y)
GECOGVIDANTO_PLUGINS += @gecogvidanto/plugin-mutcredit
endif
ifeq ($(BR2_PACKAGE_GECOGVIDANTO_LOCALE_EO),y)
GECOGVIDANTO_PLUGINS += @gecogvidanto/plugin-locale-eo
endif
ifeq ($(BR2_PACKAGE_GECOGVIDANTO_LOCALE_FR),y)
GECOGVIDANTO_PLUGINS += @gecogvidanto/plugin-locale-fr
endif

define GECOGVIDANTO_BUILD_CMDS
	cd $(@D)/packages/core/server && \
		$(NPM) install && \
		$(NPM) run build && \
		$(NPM) pack
endef

define GECOGVIDANTO_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/gecogvidanto
	tar xzf $(@D)/packages/core/server/gecogvidanto-server-*.tgz \
		-C $(TARGET_DIR)/opt/gecogvidanto --strip-components=1
	cd $(TARGET_DIR)/opt/gecogvidanto && \
		$(NPM) install --only=production && \
		$(NPM) install --only=production $(GECOGVIDANTO_PLUGINS)
endef

define GECOGVIDANTO_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(BR2_EXTERNAL_SVEYRET_PATH)/package/gecogvidanto/S99gecogvidanto \
		$(TARGET_DIR)/etc/init.d/S99gecogvidanto
endef

define GECOGVIDANTO_USERS
	gecogvidanto -1 gecogvidanto -1 * /var/db/gecogvidanto - - User created for gecogvidanto
endef

define GECOGVIDANTO_PERMISSIONS
	/var/db/gecogvidanto  d  755  gecogvidanto  gecogvidanto  -  -  -  -  -
	/etc/gecogvidanto.conf  f  644  root  root  -  -  -  -  -
endef

$(eval $(generic-package))
