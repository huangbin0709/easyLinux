#include "core.h"
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include "lib/libprocmgr.h"

int main(int argc, char*argv[])
{
#ifdef _TEST_MTD_
	int fd = -1;
	char buffer[2048] = {0};
	int n = 0;
#endif

	app_retarget_output();
	
	printf("Process core startup success\r\n");
#if _TEST_MTD_
	fd = open("/dev/mtd5",O_RDWR);
	if(fd < 0)
	{
		printf("open the mtd5 failed\r\n");
	}
	else
	{
		sprintf(buffer,"hello mtd5");
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
#endif
	sleep(5);
	system("/bin/sh");
	
	return 0;
}