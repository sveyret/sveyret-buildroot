################################################################################
#
# nullmailer
#
################################################################################

NULLMAILER_VERSION = 2.2
NULLMAILER_SOURCE = nullmailer-$(NULLMAILER_VERSION).tar.gz
NULLMAILER_SITE = http://untroubled.org/nullmailer/archive
NULLMAILER_LICENSE = GPL-2
NULLMAILER_LICENSE_FILES = COPYING
NULLMAILER_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_OPENSSL),y)
NULLMAILER_DEPENDENCIES += openssl
NULLMAILER_CONF_OPTS += --with-ssl
endif

# Remove the spool dir, as it is actually installed in tmp and will be
# re-created by permissions
define NULLMAILER_REMOVE_SPOOL_DIR
	$(RM) -rf $(TARGET_DIR)/var/spool/nullmailer
endef
NULLMAILER_POST_INSTALL_TARGET_HOOKS += NULLMAILER_REMOVE_SPOOL_DIR

define NULLMAILER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(BR2_EXTERNAL_SVEYRET_PATH)/package/nullmailer/S60nullmailer \
		$(TARGET_DIR)/etc/init.d/S60nullmailer
endef

define NULLMAILER_INSTALL_INIT_OPENRC
	$(INSTALL) -m 0755 -D $(BR2_EXTERNAL_SVEYRET_PATH)/package/nullmailer/nullmailer.openrc \
		$(TARGET_DIR)/etc/init.d/nullmailer
endef

define NULLMAILER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -m 0755 -D $(@D)/scripts/nullmailer.service \
		$(TARGET_DIR)/usr/lib/systemd/system/nullmailer.service
endef

define NULLMAILER_USERS
	nullmail 88 nullmail 88 * /var/spool/nullmailer - - User created for nullmailer
endef

define NULLMAILER_PERMISSIONS
	/usr/bin/mailq  f  4711  nullmail  nullmail  -  -  -  -  -
	/usr/sbin/nullmailer-queue  f  4711  nullmail  nullmail  -  -  -  -  -
	/var/spool/nullmailer  d  755  nullmail  root  -  -  -  -  -
	/var/spool/nullmailer/failed  d  700  nullmail  nullmail  -  -  -  -  -
	/var/spool/nullmailer/queue  d  700  nullmail  nullmail  -  -  -  -  -
	/var/spool/nullmailer/tmp  d  700  nullmail  nullmail  -  -  -  -  -
	/var/spool/nullmailer/trigger  p  600  nullmail  nullmail  -  -  -  -  -

endef

$(eval $(autotools-package))
