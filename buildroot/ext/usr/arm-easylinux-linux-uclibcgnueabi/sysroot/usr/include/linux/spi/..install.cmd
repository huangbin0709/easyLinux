cmd_/project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/spi/.install := /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/spi ./include/uapi/linux/spi spidev.h; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/spi ./include/linux/spi ; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/spi ./include/generated/uapi/linux/spi ; for F in ; do echo "\#include <asm-generic/$$F>" > /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/spi/$$F; done; touch /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/linux/spi/.install
