################################################################################
#
# demodriver
#
################################################################################
DEMODRIVER_VERSION = 1.0
DEMODRIVER_SITE = $(TOPDIR)/../src/application/drivers/demodriver
DEMODRIVER_SITE_METHOD = local
DEMODRIVER_INSTALL_STAGING = NO
DEMODRIVER_INSTALL_TARGET = YES
#DEMODRIVER_CONFIG_SCRIPTS = DEMODRIVER-config
#DEMODRIVER_DEPENDENCIES = host-libaaa libbbb

define DEMODRIVER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules
endef

#define DEMODRIVER_INSTALL_STAGING_CMDS
#	$(INSTALL) -D -m 0755 $(@D)/DEMODRIVER.a $(STAGING_DIR)/usr/lib/DEMODRIVER.a
#	$(INSTALL) -D -m 0644 $(@D)/foo.h $(STAGING_DIR)/usr/include/foo.h
#	$(INSTALL) -D -m 0755 $(@D)/DEMODRIVER.so* $(STAGING_DIR)/usr/lib
#endef

define DEMODRIVER_INSTALL_TARGET_CMDS
	cp $(@D)/*.ko $(TARGET_DIR)/easylinux/lib/modules
endef

#define DEMODRIVER_USERS
#	foo -1 DEMODRIVER -1 * - - - DEMODRIVER daemon
#endef

#define DEMODRIVER_DEVICES
#/dev/foo c 666 0 0 42 0 - - -
#endef

#define DEMODRIVER_PERMISSIONS
#/bin/foo f 4755 foo DEMODRIVER - - - - -
#endef

$(eval $(generic-package))