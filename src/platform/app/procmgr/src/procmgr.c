#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdlib.h>
#include "procmgr.h"
#include "lib/procmgr_app.h"
#include "lib/pid.h"

int main(int argc,char *argv[])
{
	pthread_t id;
	
	pid_init(PID_PROCMGR);
	app_retarget_output();
	setup_sigsegv();
	printf("\r\n\r\n\r\n\r\n\r\nWelcome to easylinux system!\r\n");
	printf("Process procmgr startup ok\r\n");
	
	if(pthread_create(&id,NULL,procmgr_collector,NULL)<0)
	{
		printf("create the collector thread error\r\n");
	}
	
	procmgrStartUpProcess("core","core");
	
	while(1)
	{
		sleep(1);
	}
	return 0;
}

void* procmgr_collector(void *arg)
{
	int status = 0;
	pid_t pid = 0;
	
	while(1)
	{
		pid = waitpid(-1,&status,0);
		if(pid > 0)
		{
			printf("process %d exit\r\n",pid);
		}
	}
	
	return 0;
}
int procmgrStartUpProcess(char *bin_name,char *name)
{
	int pid = 0;
	char path[50];
	
	printf("Ready to startup process %s\r\n",name);
	snprintf(path,sizeof(path),"%s/%s",EASYLINUX_EXE_PATH,bin_name);
	
	pid = fork();
	if(pid == 0)
	{
		if(execl(path,NULL) < 0)
		{
			printf("execl process error\r\n");
			exit(-1);
		}
		exit(0);
	}
	
	return 0;
}