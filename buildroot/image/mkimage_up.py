#!/usr/bin/python
# -*- coding: utf-8 -*-
import struct
import sys
import os
import re

	#flash.bin才需要烧写usrconf.jffs2
	#mkimage_flash.py project_name [uboot] [uImage] usrimagejffs2
def main():
	source="source/"
	img_dir = "img/"
	nouboot=0
	nokernel=0
	fn_uboot='u-boot.bin'
	fn_kernel='uImage'
	if len(sys.argv) < 3:
		print 'too few params'
		return None
	print '\r\nmake image %s_up.bin...' % (sys.argv[1])
	#print 'param[0] %s param[1] %s param[2] %s' % (sys.argv[0],sys.argv[1],sys.argv[2])
	if len(sys.argv) == 3:
		nouboot=1
		nokernel=1
		fn_usrimage=sys.argv[2]
		print 'the image does not contains uboot and kernel'
	if len(sys.argv) == 4:
		patt = 'uImage'
		ret = re.match(patt,sys.argv[2])
		if ret is None:
			nokernel=1
			fn_uboot = sys.argv[2]
			print 'the image does not contains kernel'
		else:
			nouboot=1
			fn_kernel = sys.argv[2]
			print 'the image does not contains uboot'
		fn_usrimage=sys.argv[3]
	if len(sys.argv) > 4:
		fn_uboot = sys.argv[2]
		fn_kernel = sys.argv[3]
		fn_usrimage = sys.argv[4]
		print 'the image contains all'
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
			print 'error: Open %s failed.' %(fn_uboot)
			return None
		uboot_file.seek(0,os.SEEK_END)
		uboot_len=uboot_file.tell()
		print 'uboot size is 0x%x' % uboot_len
		uboot_file.seek(0,os.SEEK_SET)
		uboot_img =uboot_file.read()
		uboot_file.close()
		#make sure the profile len can be dived by 4
		pad_index=uboot_len%4
		uboot_img=uboot_img+pad_table4[pad_index]	
		
	kernel_len = 0
	if nokernel == 0:
		kernel_file =open(source+fn_kernel,'rb')
		if kernel_file is None:
			print 'error: Open %s failed.' %(fn_kernel)
			return None
		kernel_file.seek(0,os.SEEK_END)
		kernel_len=kernel_file.tell()
		print 'kernel size is 0x%x' % kernel_len
		kernel_file.seek(0,os.SEEK_SET)
		kernel_img =kernel_file.read()
		kernel_file.close()
		#make sure the profile len can be dived by 4
		pad_index=kernel_len%4
		kernel_img=kernel_img+pad_table4[pad_index]	
		
	usrimage_file = open(source+fn_usrimage,'rb')
	if usrimage_file is None:
		print 'error: Open %s failed.' %(fn_usrimage)
		return None
	usrimage_file.seek(0,os.SEEK_END)
	usrimage_len=usrimage_file.tell()
	print 'usrimage size is 0x%x' % usrimage_len
	usrimage_file.seek(0,os.SEEK_SET)
	usrimage_img =usrimage_file.read()
	usrimage_file.close()
	#make sure the profile len can be dived by 4
	pad_index=usrimage_len%4
	usrimage_img=usrimage_img+pad_table4[pad_index]	
	#1 - LZMA not used yet
	compress_method=1
	#define the flash distributiong
	flashver = '0x010000'
	sfver = '0x010000'
	ver = flashver+sfver
	print 'flashver %s'%flashver
	print 'soferver %s'%sfver
	#                    sz_boot  kernel_off  kernel_sz  img1_off   img1_sz    img2_off    img2_sz  usrconf_off usrconf_sz  version
	flashDistributeInfo=('0xa0000','0xa0000','0x400000','0x4a0000','0x800000','0x0000000','0x000000','0xca0000','0x200000', ver)
	#gen image header
	fmt = struct.Struct('>16s16sLLLL16s16s16s16s16s16s16s16s16s16s304x')
	image_header=fmt.pack(flash_md5,product_id,usrimage_len,kernel_len,uboot_len,compress_method,flashDistributeInfo[0],
	flashDistributeInfo[1],flashDistributeInfo[2],flashDistributeInfo[3],flashDistributeInfo[4],flashDistributeInfo[5],
	flashDistributeInfo[6],flashDistributeInfo[7],flashDistributeInfo[8],flashDistributeInfo[9])
	image=image_header+usrimage_img
	if nokernel == 0:
		image=image+kernel_img
	if nouboot == 0:
		image=image+uboot_img
		
	image_file =open(img_dir+sys.argv[1]+'_up.bin','wb')
	if image_file is None:
		print 'error: Open imgfile failed.'
		return None
	image_file.write(image)
	#可写固定个数
	#image_file.write('0xFF'*size)
	image_file.close()

if __name__=="__main__":   
    main()
