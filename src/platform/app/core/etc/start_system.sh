#!/bin/sh
echo "start system,please wait..."
#更改printk打印级别
echo 4 > /proc/sys/kernel/printk
mkdir -p /mnt/easylinux
mkdir -p /mnt/usrconf
#mount -t squashfs /dev/mtdblock3 /mnt/easylinux
mount -t jffs2 /dev/mtdblock4 /mnt/usrconf
mkdir -p /easylinux
mount -t ramfs none /easylinux
#cp -rf /mnt/easylinux/* /easylinux
export PATH=$PATH:/easylinux/app/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/easylinux/lib
/usr/bin/core
echo "something error,we should not go here"


