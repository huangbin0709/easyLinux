#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int app_retarget_output(void)
{
	int fd = -1;
	
	fd = open("/dev/ttySAC0",O_RDWR);
	if(fd < 0)
	{
		printf("can not open console\r\n");
	}
	dup2(fd,STDOUT_FILENO);
	close(fd);
	
	setvbuf(stdout,NULL, _IONBF,0);
	 
	return 0;
}