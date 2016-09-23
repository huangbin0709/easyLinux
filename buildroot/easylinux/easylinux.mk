#first set easylinux envirnoment
BR2_BOARD_COMMON_DIR = $(TOPDIR)/board/$(BR2_EASYLINUX_VENDOR)/common
BR2_BOARD_COMMON_DIR_STRIP = $(call qstrip,$(BR2_BOARD_COMMON_DIR))
BR2_BOARD_CUSTOM_DIR = $(TOPDIR)/board/$(BR2_EASYLINUX_VENDOR)/$(BR2_EASYLINLUX_BOARD_NAME)
BR2_BOARD_CUSTOM_DIR_STRIP = $(call qstrip,$(BOARD_CUSTOM_DIR))
BR2_EASYLINUX_SOURCE_DIR = $(TOPDIR)/../src
BR2_EASYLINUX_ARCHIVE_DIR = $(TOPDIR)/../archive/$(BR2_EASYLINUX_PROJECT_NAME)
BR2_EASYLINUX_STATIC_LIB_DIR = $(EASYLINUX_ARCHIVE_DIR)
BR2_EASYLINUX_DYNAMIC_LIB_DIR = $(EASYLINUX_ARCHIVE_DIR)/dynamic

#include all easylinux app mk files
#save the buildpath,we will fix the builddir to easylinux dir later
build_saved_dir := $(BUILD_DIR)
#change the path to easylinux
export BUILD_DIR := $(build_saved_dir)/easylinux
include $(sort $(wildcard easylinux/*/*.mk))
#now restore the path
export BUILD_DIR := $(build_saved_dir)

easylinux-clean:
	$(TOPDIR)/easylinux_patch_clean.sh $(TOPDIR) $(BUILD_DIR) $(BR2_EASYLINUX_PROJECT_NAME)

