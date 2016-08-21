#first set easylinux envirnoment
BOARD_COMMON_DIR = $(TOPDIR)/board/$(BR2_EASYLINUX_VENDOR)/common
BOARD_CUSTOM_DIR = $(TOPDIR)/board/$(BR2_EASYLINUX_VENDOR)/$(BR2_EASYLINLUX_BOARD_NAME)
EASYLINUX_SOURCE_DIR = $(TOPDIR)/../src
EASYLINUX_ARCHIVE_DIR = $(TOPDIR)/../archive/$(BR2_EASYLINUX_PROJECT_NAME)
EASYLINUX_STATIC_LIB_DIR = $(EASYLINUX_ARCHIVE_DIR)
EASYLINUX_DYNAMIC_LIB_DIR = $(EASYLINUX_ARCHIVE_DIR)/usr/lib

#include all easylinux app mk files
#save the buildpath,we will fix the builddir to easylinux dir later
build_saved_dir := $(BUILD_DIR)
#unexport BUILD_DIR
BUILD_DIR := "$(build_saved_dir)/easylinux"
#export BUILD_DIR
include easylinux/*/*.mk
#now restore the path
BUILD_DIR := $(build_saved_dir)
#export BUILD_DIR

easylinux-clean:
	$(TOPDIR)/easylinux_patch_clean.sh $(TOPDIR) $(BUILD_DIR) $(BR2_EASYLINUX_PROJECT_NAME)

