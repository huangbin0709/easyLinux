################################################################################
#
# Build the yaffs2 root filesystem image
#
################################################################################

ROOTFS_YAFFS2_DEPENDENCIES = host-yaffs2utils

define ROOTFS_YAFFS2_CMD
	$(HOST_DIR)/usr/bin/mkyaffs2 --all-root $(TARGET_DIR)/../tmptarget/easylinux $(BINARIES_DIR)/usrimage.yaffs
endef

$(eval $(call ROOTFS_TARGET,yaffs2))
