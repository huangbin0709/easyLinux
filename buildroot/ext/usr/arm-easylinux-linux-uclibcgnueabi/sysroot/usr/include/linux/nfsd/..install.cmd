cmd_/project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/nfsd/.install := /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/nfsd ./include/uapi/linux/nfsd cld.h debug.h export.h nfsfh.h stats.h; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/nfsd ./include/linux/nfsd ; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/nfsd ./include/generated/uapi/linux/nfsd ; for F in ; do echo "\#include <asm-generic/$$F>" > /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/nfsd/$$F; done; touch /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/nfsd/.install
