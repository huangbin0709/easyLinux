#!/bin/sh
echo "start system,please wait..."
#更改printk打印级别
echo 0 > /proc/sys/kernel/printk
#不产生coredump文件
ulimit -c 0
mkdir -p /mnt/easylinux
mkdir -p /mnt/usrconf
echo "try to mount usrimage as cramfs..."
mount -t cramfs /dev/mtdblock3 /mnt/easylinux
if [ $? -ne 0 ];then
	echo "mount failed,try to mount as squashfs"
	mount -t squashfs /dev/mtdblock3 /mnt/easylinux
	if [ $? -ne 0 ];then
		echo "mount failed,try to mount as jffs2"
		mount -t jffs2 /dev/mtdblock3 /mnt/easylinux
	fi
fi
mount -t jffs2 /dev/mtdblock4 /mnt/usrconf
mkdir -p /easylinux
mount -t ramfs none /easylinux
cp -rf /mnt/easylinux/* /easylinux
chmod 0644 /easylinux/lib/*.so
export PATH=$PATH:/easylinux/app/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/easylinux/lib
while true
do
killall -9 procmgr
/usr/bin/procmgr
done
echo "something error,we should not go here"


