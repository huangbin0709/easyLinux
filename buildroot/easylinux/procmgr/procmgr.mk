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

PROCMGR_CFLAGS += $(BR2_EASYLINUX_CFLAGS)
#PROCMGR_CFLAGS += 
PROCMGR_CONF_OPTS += -DCMAKE_C_FLAGS="$(PROCMGR_CFLAGS)"
$(eval $(cmake-package))
