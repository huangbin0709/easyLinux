################################################################################
#
# core
#
################################################################################
CORE_VERSION = 1.0
CORE_SITE = $(TOPDIR)/../src/platform/app/core
CORE_SITE_METHOD = local
CORE_INSTALL_STAGING = NO
CORE_INSTALL_TARGET = YES
#CORE_CONF_OPTS +=
#CORE_DEPENDENCIES +=
$(eval $(cmake-package))