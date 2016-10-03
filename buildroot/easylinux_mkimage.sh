#!/bin/sh
image_dir=$2/image
if [ ! -d $image_dir ];
then
    mkdir -p $image_dir
fi

rm -rf $2/image/*
cp -rf $3/* $2/image

echo "gzip -9 Image"
gzip -9 $image_dir/Image
$1/usr/bin/mkimage -A arm -O linux -T kernel -C gzip -a 0x30008000 -e 0x30008000 -n "easylinux" -d $image_dir/Image.gz $image_dir/uImage