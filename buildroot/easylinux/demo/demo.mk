################################################################################
#
# DEMO
#
################################################################################
DEMO_VERSION = 1.0
DEMO_SITE = $(TOPDIR)/../src/application/app/demo
DEMO_SITE_METHOD = local
DEMO_INSTALL_STAGING = NO
DEMO_INSTALL_TARGET = YES
DEMO_INSTALL_TARGET_OPTS = DESTDIR=$(BR2_EASYLINUX_ARCHIVE_DIR) install
#DEMO_CONF_OPTS +=
#DEMO_DEPENDENCIES +=

DEMO_CFLAGS += $(BR2_EASYLINUX_CFLAGS_STRIP)
#DEMO_CFLAGS += 
DEMO_CONF_OPTS += -DCMAKE_C_FLAGS="$(DEMO_CFLAGS)"
$(eval $(cmake-package))