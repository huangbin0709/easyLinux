cmd_/project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/scsi/.install := /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/scsi ./include/uapi/scsi scsi_bsg_fc.h scsi_netlink.h scsi_netlink_fc.h; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/scsi ./include/scsi ; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/scsi ./include/generated/uapi/scsi ; for F in ; do echo "\#include <asm-generic/$$F>" > /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/scsi/$$F; done; touch /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/scsi/.install
