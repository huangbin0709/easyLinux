#!/bin/sh
echo "start system,please wait..."
#更改printk打印级别
echo 4 > /proc/sys/kernel/printk
mkdir -p /mnt/easylinux
mkdir -p /mnt/usrconf
mount -t jffs2 /dev/mtdblock3 /mnt/easylinux
mount -t jffs2 /dev/mtdblock4 /mnt/usrconf
mkdir -p /easylinux
mount -t ramfs none /easylinux
cp -rf /mnt/easylinux/* /easylinux
chmod 0644 /easylinux/lib/*.so
export PATH=$PATH:/easylinux/app/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/easylinux/lib
/usr/bin/procmgr
echo "something error,we should not go here"


