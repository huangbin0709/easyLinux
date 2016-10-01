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

ifeq ($(BR2_EASYLINUX_DEMO),y)
	CORE_INC += -DINC_APP_DEMO
	CORE_DEPENDENCIES += demo
	CORE_APP_LIBS += libdemo.a
endif

CORE_CFLAGS += $(BR2_EASYLINUX_CFLAGS)
#CORE_CFLAGS += 
CORE_CONF_OPTS += -DCMAKE_C_FLAGS="$(CORE_CFLAGS) $(CORE_INC) -Wall -Werror -fno-builtin -pthread -lm -lrt"
$(eval $(cmake-package))