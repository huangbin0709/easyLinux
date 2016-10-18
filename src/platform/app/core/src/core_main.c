#include "core.h"
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include "lib/libprocmgr.h"

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
	printf("    Enter your selection:");
}

void sysReboot(void)
{
	printf("rebooting,please wait...\r\n");
	system("sync");
	system("echo 3 > /proc/sys/vm/drop_caches");
	system("reboot");
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

int main(int argc, char*argv[])
{
	char c;
	
	app_retarget_output();
	
	printf("Process core startup ok\r\n\r\n\r\n\r\n");
	
	sleep(5);
	
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
			default:
			break;
			
		}
	}
	
	
	return 0;
}