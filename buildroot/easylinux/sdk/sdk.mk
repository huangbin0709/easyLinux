################################################################################
#
# SDK
#
################################################################################
SDK_VERSION = 1.0
#虚拟目录，只是为了满足buildroot拷贝机制，编译时直接指定真实路径
SDK_SITE = $(TOPDIR)/easylinux/sdk/sdk_dummy
SDK_SITE_METHOD = local
SDK_INSTALL_STAGING = NO
SDK_INSTALL_TARGET = YES
#SDK_CONFIG_SCRIPTS = SDK-config
SDK_DEPENDENCIES = linux

define SDK_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(LINUX_MAKE_FLAGS) -C $(BR2_EASYLINUX_SDK_DIR)
endef

#define SDK_INSTALL_STAGING_CMDS
#	$(INSTALL) -D -m 0755 $(@D)/SDK.a $(STAGING_DIR)/usr/lib/SDK.a
#	$(INSTALL) -D -m 0644 $(@D)/foo.h $(STAGING_DIR)/usr/include/foo.h
#	$(INSTALL) -D -m 0755 $(@D)/SDK.so* $(STAGING_DIR)/usr/lib
#endef

#define SDK_INSTALL_TARGET_CMDS
#	cp $(@D)/*.ko $(TARGET_DIR)/easylinux/lib/modules
#endef

#define SDK_USERS
#	foo -1 SDK -1 * - - - SDK daemon
#endef

#define SDK_DEVICES
#/dev/foo c 666 0 0 42 0 - - -
#endef

#define SDK_PERMISSIONS
#/bin/foo f 4755 foo SDK - - - - -
#endef

$(eval $(generic-package))