#include "core.h"
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char*argv[])
{
	int fd = -1;
	
	fd = open("/dev/ttySAC0",O_RDWR);
	if(fd < 0)
	{
		printf("can not open console\r\n");
	}
	dup2(fd,STDOUT_FILENO);
	close(fd);
	
	printf("core app startup success\r\n");
	sleep(5);
	system("/bin/sh");
	
	return 0;
}