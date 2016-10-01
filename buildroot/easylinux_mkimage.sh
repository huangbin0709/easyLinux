#!/bin/sh
echo "gzip -9 Image"
gzip -9 $2/Image
$1/usr/bin/mkimage -A arm -O linux -T kernel -C gzip -a 0x30008000 -e 0x30008000 -n "easylinux" -d $2/Image.gz $2/uImage