#!/usr/bin/python
# -*- coding: utf-8 -*-
import struct
import sys
import os
import re

#flash.bin才需要烧写usrconf.jffs2
#mkimage_flash.py project_name [uboot] uImage usrimagejffs2 usrconf.jffs2
def main():
	source="source/"
	img_dir = "img/"
	nouboot=0
	nokernel=0
	if len(sys.argv) < 5:
		print 'flash.bin must contained kernel and usrimage'
		return None
	if len(sys.argv) == 5:
		nouboot=1
		fn_kernel = sys.argv[2]
		fn_usrimage=sys.argv[3]
		fn_usrconf=sys.argv[4]
	else:
		fn_uboot = sys.argv[2]
		fn_kernel = sys.argv[3]
		fn_usrimage=sys.argv[4]	
		fn_usrconf=sys.argv[5]
	#default 16bytes md5,md5 is calculated by tpGenMd5Image
	flash_md5 = 'md50md50md50md50'
	product_id = '1234567891234567'
	#for alias to 4bytes
	pad_table4=('','\0\0\0','\0\0','\0')
	#for alias to 16bytes
	pad_table16 = ('','\0\0\0\0\0\0\0\0\0\0\0\0','\0\0\0\0\0\0\0\0','\0\0\0\0')

	uboot_len = 0
	if nouboot == 0:
		uboot_file =open(source+fn_uboot,'rb')
		if uboot_file is None:
			print 'ERR: Open %s failed.' %(fn_uboot)
			return None
		uboot_file.seek(0,os.SEEK_END)
		uboot_len=uboot_file.tell()
		uboot_file.seek(0,os.SEEK_SET)
		uboot_img =uboot_file.read()
		uboot_file.close()
		#
		uboot_pad_len=0xa0000-uboot_len
		
	kernel_len = 0

	kernel_file =open(source+fn_kernel,'rb')
	if kernel_file is None:
		print 'ERR: Open %s failed.' %(fn_kernel)
		return None
	kernel_file.seek(0,os.SEEK_END)
	kernel_len=kernel_file.tell()
	kernel_file.seek(0,os.SEEK_SET)
	kernel_img =kernel_file.read()
	kernel_file.close()
	#
	kernel_pad_len=0x400000-kernel_len
		
	usrimage_file = open(source+fn_usrimage,'rb')
	if usrimage_file is None:
		print 'ERR: Open %s failed.' %(fn_usrimage)
		return None
	usrimage_file.seek(0,os.SEEK_END)
	usrimage_len=usrimage_file.tell()
	usrimage_file.seek(0,os.SEEK_SET)
	usrimage_img =usrimage_file.read()
	usrimage_file.close()
	#
	usrimage_pad_len=0x800000-usrimage_len
	#
	
	usrconf_file = open(source+fn_usrconf,'rb')
	if usrconf_file is None:
		print 'ERR: Open %s failed.' %(fn_usrconf)
		return None
	usrconf_file.seek(0,os.SEEK_END)
	usrconf_len=usrconf_file.tell()
	usrconf_file.seek(0,os.SEEK_SET)
	usrconf_img =usrconf_file.read()
	usrconf_file.close()
	#
	usrconf_pad_len=0x200000-usrconf_len
	#
	if nouboot == 1:
		format='>'+str(kernel_len)+'s'+str(kernel_pad_len)+'x'+str(usrimage_len)+'s'+str(usrimage_pad_len)+'x'+str(usrconf_len)+'s'+str(usrconf_pad_len)+'x'
		fmt = struct.Struct(format)
		image=fmt.pack(kernel_img,usrimage_img,usrconf_img)
	else:
		format='>'+str(uboot_len)+'s'+str(uboot_pad_len)+'x'+str(kernel_len)+'s'+str(kernel_pad_len)+'x'+str(usrimage_len)+'s'+str(usrimage_pad_len)+'x'+str(usrconf_len)+'s'+str(usrconf_pad_len)+'x'
		fmt = struct.Struct(format)
		image=fmt.pack(uboot_img,kernel_img,usrimage_img,usrconf_img)		

	image_file =open(img_dir+sys.argv[1]+'_flash.bin','wb')
	if image_file is None:
		print 'ERR: Open imgfile failed.'
		return None
	image_file.write(image)
	image_file.close()
	
if __name__=="__main__":   
    print("mkimage flash.bin....")   
    main()
	