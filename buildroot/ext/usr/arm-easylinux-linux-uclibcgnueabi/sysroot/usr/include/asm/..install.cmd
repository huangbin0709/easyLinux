cmd_/project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/asm/.install := /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/asm ./arch/arm/include/uapi/asm byteorder.h fcntl.h hwcap.h ioctls.h kvm.h kvm_para.h mman.h perf_regs.h posix_types.h ptrace.h setup.h sigcontext.h signal.h stat.h statfs.h swab.h unistd.h; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/asm ./arch/arm/include/asm types.h; /bin/sh scripts/headers_install.sh /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/asm ./arch/arm/include/generated/uapi/asm ; for F in auxvec.h bitsperlong.h errno.h ioctl.h ipcbuf.h msgbuf.h param.h poll.h resource.h sembuf.h shmbuf.h siginfo.h socket.h sockios.h termbits.h termios.h; do echo "\#include <asm-generic/$$F>" > /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/asm/$$F; done; touch /project/trunk/easyLinux/buildroot/build/easylinux_tools/host/usr/arm-easylinux-linux-uclibcgnueabi/sysroot/usr/include/asm/.install
