#!/bin/sh
image_dir=$2/image/source
if [ ! -d $image_dir ];
then
    mkdir -p $image_dir
fi

rm -rf $2/image/source/*
rm -rf $2/image/img/*
cp -rf $3/* $image_dir

echo "gzip -9 Image"
gzip -9 $image_dir/Image
$1/usr/bin/mkimage -A arm -O linux -T kernel -C gzip -a 0x30008000 -e 0x30008000 -n "easylinux" -d $image_dir/Image.gz $image_dir/uImage
cd $2/image && \
python mkimage_up.py "gt2440_exclude_uboot" "uImage" "usrimage.jffs2" && \
python mkimage_up.py "gt2440_exclude_uboot_kernel" "usrimage.jffs2" && \
python mkimage_up.py "gt2440_all" "u-boot.bin" "uImage" "usrimage.jffs2"  && \
python mkimage_flash.py "gt2440_exclude_uboot" "uImage" "usrimage.jffs2" "usrconf.jffs2" && \
python mkimage_flash.py "gt2440_all" "u-boot.bin" "uImage" "usrimage.jffs2" "usrconf.jffs2"
