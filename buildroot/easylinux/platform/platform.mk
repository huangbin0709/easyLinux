################################################################################
#
# PLATFORM
#
################################################################################
PLATFORM_VERSION = 1.0
PLATFORM_SITE = $(TOPDIR)/../src/platform/lib
PLATFORM_SITE_METHOD = local
PLATFORM_INSTALL_STAGING = NO
PLATFORM_INSTALL_TARGET = YES
PLATFORM_INSTALL_TARGET_OPTS = DESTDIR=$(BR2_EASYLINUX_ARCHIVE_DIR) install
#PLATFORM_CONF_OPTS +=
#PLATFORM_DEPENDENCIES +=

PLATFORM_CFLAGS += $(BR2_EASYLINUX_CFLAGS_STRIP)
PLATFORM_CFLAGS += -D__arm__
PLATFORM_CONF_OPTS += -DCMAKE_C_FLAGS="$(PLATFORM_CFLAGS)"
$(eval $(cmake-package))