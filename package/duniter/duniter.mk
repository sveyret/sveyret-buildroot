################################################################################
#
# duniter
#
################################################################################

DUNITER_VERSION = v1.8.0
DUNITER_SOURCE = duniter-$(DUNITER_VERSION).tar.gz
DUNITER_SITE = https://git.duniter.org/nodes/typescript/duniter/-/archive/$(DUNITER_VERSION)
DUNITER_LICENSE = AGPL-3
DUNITER_LICENSE_FILES = LICENSE
DUNITER_DEPENDENCIES = host-rustc
DUNITER_BIN_ARCH_EXCLUDE = /opt/duniter/node_modules/leveldown/prebuilds

ifeq ($(BR2_i386),y)
DUNITER_PARAM_ARCH = ia32
else ifeq ($(BR2_x86_64),y)
DUNITER_PARAM_ARCH = x64
else ifeq ($(BR2_mips),y)
DUNITER_PARAM_ARCH = mips
else ifeq ($(BR2_mipsel),y)
DUNITER_PARAM_ARCH = mipsel
else ifeq ($(BR2_arm),y)
DUNITER_PARAM_ARCH = arm
else ifeq ($(BR2_aarch64),y)
DUNITER_PARAM_ARCH = arm64
endif
DUNITER_PARAM_PLATFORM = linux
DUNITER_PARAM_DEBUG = $(if $(BR2_ENABLE_DEBUG),Y,N)
ifeq ($(BR2_PACKAGE_DUNITER_GUI),y)
DUNITER_PARAM_TARGET = server-gui
else
DUNITER_PARAM_TARGET = server
endif

export NPM
DUNITER_MAKE_CALL = \
	DUNITER_FAST_BUILD=Y \
	CARGO_HOME=$(CARGO_HOME) \
	CARGO_BUILD_TARGET=$(RUSTC_TARGET_NAME) \
	$(MAKE) \
	ARCH=$(DUNITER_PARAM_ARCH) \
	PLATFORM=$(DUNITER_PARAM_PLATFORM) \
	ADD_DEBUG=$(DUNITER_PARAM_DEBUG) \
	-C $(@D)/release

define DUNITER_CONFIGURE_CMDS
	$(SED) 's/npm\s/\$$(NPM) /' $(@D)/release/Makefile
endef

define DUNITER_BUILD_CMDS
	$(DUNITER_MAKE_CALL) $(DUNITER_PARAM_TARGET)
	$(DUNITER_MAKE_CALL) clean
	echo 'DUNITER_DIR="/opt/duniter"' >$(@D)/work-duniter.sh
	echo 'cd "$$DUNITER_DIR"' >>$(@D)/work-duniter.sh
	echo 'node "$$DUNITER_DIR/bin/duniter" "$$@"' >>$(@D)/work-duniter.sh
	mv $(@D)/work/extra $(@D)/work-extra
endef

define DUNITER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt
	$(INSTALL) -m 0755 $(@D)/work-duniter.sh $(TARGET_DIR)/usr/bin/duniter
	rm -rf $(TARGET_DIR)/opt/duniter
	mv $(@D)/work $(TARGET_DIR)/opt/duniter
endef

define DUNITER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(BR2_EXTERNAL_SVEYRET_PATH)/package/duniter/S99duniter \
		$(TARGET_DIR)/etc/init.d/S99duniter
endef

define DUNITER_INSTALL_INIT_OPENRC
	$(INSTALL) -m 0755 $(@D)/work-extra/openrc/duniter.initd $(TARGET_DIR)/etc/init.d/duniter
	$(INSTALL) -m 0644 $(@D)/work-extra/openrc/duniter.confd $(TARGET_DIR)/etc/conf.d/duniter
endef

define DUNITER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -m 0644 $(@D)/work-extra/systemd/duniter.service \
		$(TARGET_DIR)/usr/lib/sysusers.d/duniter.conf
endef

define DUNITER_USERS
	duniter -1 duniter -1 * /var/lib/duniter - - User created for duniter
endef

define DUNITER_PERMISSIONS
	/var/lib/duniter  d  755  duniter  duniter  -  -  -  -  -
endef

$(eval $(generic-package))
