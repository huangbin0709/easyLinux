################################################################################
#
# CORE
#
################################################################################
CORE_VERSION = 1.0
CORE_SITE = $(TOPDIR)/../src/platform/app/core
CORE_SITE_METHOD = local
CORE_INSTALL_STAGING = NO
CORE_INSTALL_TARGET = YES
#CORE_CONF_OPTS +=
#CORE_DEPENDENCIES +=

define CORE_COPY_DATA
chmod 777 $(TARGET_DIR)/etc/init.d -R
rm -rf $(TARGET_DIR)/etc/init.d/*
chmod 777 $(CORE_SITE)/etc -R
cp -rf $(CORE_SITE)/etc/inittab $(TARGET_DIR)/etc
cp -rf $(CORE_SITE)/etc/start_system.sh $(TARGET_DIR)/etc
cp -rf $(CORE_SITE)/etc/init.d/* $(TARGET_DIR)/etc/init.d/
endef
#CORE_POST_INSTALL_TARGET_HOOKS += CORE_COPY_DATA

ifeq ($(BR2_EASYLINUX_DEMO),y)
	CORE_INC += -DINC_APP_DEMO
	CORE_DEPENDENCIES += demo
	CORE_LIBS += demo
endif

ifeq ($(BR2_EASYLINUX_PLATFORM),y)
	CORE_DEPENDENCIES += platform
	CORE_LIBS += libplatform.so
endif

CORE_CFLAGS += $(BR2_EASYLINUX_CFLAGS_STRIP)
CORE_CFLAGS += -D_TEST_MTD_
CORE_CFLAGS += -Wall -fno-builtin
CORE_CONF_OPTS += -DLINK_LIB="$(CORE_LIBS)"
CORE_CONF_OPTS += -DCMAKE_C_FLAGS="$(CORE_CFLAGS) $(CORE_INC)"

$(eval $(cmake-package))