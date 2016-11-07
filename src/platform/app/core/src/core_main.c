#include "core.h"
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include "lib/procmgr_app.h"
#include "lib/pid.h"
#include "lib/mid.h"
#include "lib/demo.h"
#include "gdsl/gdsl.h"
#include "common/eaTypes.h"

const char *gCompileDate = __DATE__;
const char *gCompileTime = __TIME__;

void printHelp(void)
{
	printf("\r\n");
	printf("                    Easylinux System                   \r\n");
	//printf("        author:huangbin    email:523182570@qq.com      \r\n");
	printf("              %-20s%s\r\n",gCompileDate,gCompileTime);
	printf("       1.start the bash shell.\r\n");
	printf("       2.reset the config.\r\n");
	printf("       3.upgrade the system.\r\n");
	printf("       4.reboot the system.\r\n");
#ifdef _TEST_MTD_
	printf("       5.test the nand flash.\r\n");
#endif
	printf("       6.test coredump.\r\n");
	printf("    Enter your selection:");
}

void sysReboot(void)
{
	printf("rebooting,please wait...\r\n");
	system("sync");
	system("echo 3 > /proc/sys/vm/drop_caches");
	system("reboot");
   /*等待直到重启完成*/
	while(1);
}

void sysReset(void)
{
	system("rm -rf /mnt/usrconf/conf/*");
}

#ifdef _TEST_MTD_
void testNandFlash(void)
{
	int fd = -1;
	char buffer[2048] = {0};
	int n = 0;

	fd = open("/dev/mtd5",O_RDWR);
	if(fd < 0)
	{
		printf("open the mtd5 failed\r\n");
	}
	else
	{
		sprintf(buffer,"testing the mtd5,write to");
		n = write(fd,buffer,sizeof(buffer));
		if(n <= 0)
		{
			printf("write to mtd5 error\r\n");
		}
		else
		{
			memset(buffer,0,sizeof(buffer));
			lseek(fd,0,SEEK_SET);
			n = read(fd,buffer,sizeof(buffer));
			printf("read from mtd5 is %s\r\n",buffer);
		}
		close(fd);
	}	
}
#endif

int core_main()
{
	char c;
	
	printf("Process core startup ok\r\n\r\n\r\n\r\n");
	
	sleep(5);
	/*控制进程初始化顺序*/
	mm_load_plugin(MID_SYSMANAGE,NULL,TRUE);
	
	while(1)
	{
		printHelp();
		do {
			c = getchar();
			//putchar(c);
		}while(c == '\n');
		switch(c)
		{
			case '1':
				system("/bin/sh");
			break;
			case '2':
				sysReset();
				break;
			case '4':
				sysReboot();
				break;
#ifdef _TEST_MTD_
			case '5':
				testNandFlash();
				break;
#endif
			case '6':
			    demo_test_coredump();
				break;
			default:
			break;
			
		}
	}
	
	
	return 0;
}

int main(int argc,char *argv[])
{
	/*初始化上半部*/
	baseInit_th(PID_CORE);
	/*初始化平台服务*/
	platform_init(0);
	/*各模块初始化函数*/
	core_main();
	/*初始化下半部*/
	baseInit_bh();
	
	return 0;
}