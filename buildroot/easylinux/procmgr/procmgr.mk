################################################################################
#
# procmgr
#
################################################################################
PROCMGR_VERSION = 1.0
PROCMGR_SITE = $(TOPDIR)/../src/platform/app/procmgr
PROCMGR_SITE_METHOD = local
PROCMGR_INSTALL_STAGING = NO
PROCMGR_INSTALL_TARGET = YES
#PROCMGR_CONF_OPTS +=
#PROCMGR_DEPENDENCIES +=

define PROCMGR_COPY_DATA
chmod 777 $(TARGET_DIR)/etc/init.d -R
rm -rf $(TARGET_DIR)/etc/init.d/*
chmod 777 $(PROCMGR_SITE)/etc -R
cp -rf $(PROCMGR_SITE)/etc/inittab $(TARGET_DIR)/etc
cp -rf $(PROCMGR_SITE)/etc/start_system.sh $(TARGET_DIR)/etc
cp -rf $(PROCMGR_SITE)/etc/init.d/* $(TARGET_DIR)/etc/init.d/
endef
PROCMGR_POST_INSTALL_TARGET_HOOKS += PROCMGR_COPY_DATA

PROCMGR_DEPENDENCIES += platform
PROCMGR_LIBS += libplatform.so

PROCMGR_CFLAGS += $(BR2_EASYLINUX_CFLAGS_STRIP)
PROCMGR_CFLAGS += -fno-builtin
PROCMGR_CONF_OPTS += -DLINK_LIB="$(PROCMGR_LIBS)"
PROCMGR_CONF_OPTS += -DCMAKE_C_FLAGS="$(PROCMGR_CFLAGS)"
$(eval $(cmake-package))
