cmd_/project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/video/.install := /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/video ./include/uapi/video edid.h sisfb.h uvesafb.h; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/video ./include/video ; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/video ./include/generated/uapi/video ; for F in ; do echo "\#include <asm-generic/$$F>" > /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/video/$$F; done; touch /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/video/.install
