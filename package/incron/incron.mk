################################################################################
#
# incron
#
################################################################################

INCRON_VERSION = 0.5.12_p20191114
INCRON_COMMIT_VERSION = 1eedfbc9b318372efd119fd17f4abdbde561a53d
INCRON_SOURCE = $(INCRON_COMMIT_VERSION).tar.gz
INCRON_SITE = https://github.com/ar-/incron/archive
INCRON_LICENSE = GPL-2
INCRON_LICENSE_FILES = COPYING

define INCRON_BUILD_CMDS
	$(MAKE) CXX="$(TARGET_CXX)" -C $(@D)
endef

define INCRON_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/share/man/man1
	$(INSTALL) -m 0644 $(@D)/incrontab.1 $(TARGET_DIR)/usr/share/man/man1
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/share/man/man5
	$(INSTALL) -m 0644 $(@D)/incrontab.5 $(TARGET_DIR)/usr/share/man/man5
	$(INSTALL) -m 0644 $(@D)/incron.conf.5 $(TARGET_DIR)/usr/share/man/man5
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/share/man/man8
	$(INSTALL) -m 0644 $(@D)/incrond.8 $(TARGET_DIR)/usr/share/man/man8
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 04755 $(@D)/incrontab $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/sbin/
	$(INSTALL) -m 0755 $(@D)/incrond $(TARGET_DIR)/usr/sbin/
endef

define INCRON_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(BR2_EXTERNAL_SVEYRET_PATH)/package/incron/S35incron \
		$(TARGET_DIR)/etc/init.d/S35incron
endef

define INCRON_INSTALL_INIT_OPENRC
	$(INSTALL) -m 0755 -D $(BR2_EXTERNAL_SVEYRET_PATH)/package/incron/incron.openrc \
		$(TARGET_DIR)/etc/init.d/incron
endef

define INCRON_INSTALL_INIT_SYSTEMD
	$(INSTALL) -m 0755 -D $(BR2_EXTERNAL_SVEYRET_PATH)/package/incron/incron.systemd \
		$(TARGET_DIR)/usr/lib/systemd/system/incron.service
endef

define INCRON_PERMISSIONS
	/usr/bin  d  755  root  root  -  -  -  -  -
	/usr/bin/incrontab  f  4755  root  root  -  -  -  -  -
	/usr/sbin  d  755  root  root  -  -  -  -  -
	/usr/sbin/incrond  f  755  root  root  -  -  -  -  -
	/var/spool/incron  d  755  root  root  -  -  -  -  -
	/etc/incron.d  d  755  root  root  -  -  -  -  -
endef

$(eval $(generic-package))
