cmd_/project/trunk/easyLinux/buildroot/build/toolchain/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/isdn/.install := /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/toolchain/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/isdn ./include/uapi/linux/isdn capicmd.h; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/toolchain/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/isdn ./include/linux/isdn ; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/toolchain/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/isdn ./include/generated/uapi/linux/isdn ; for F in ; do echo "\#include <asm-generic/$$F>" > /project/trunk/easyLinux/buildroot/build/toolchain/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/isdn/$$F; done; touch /project/trunk/easyLinux/buildroot/build/toolchain/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/isdn/.install
