#include <stdlib.h>
#include "lib/pid.h"

int currentPid = 0;

static pidw_t pid_table[]=
{
	{PID_PROCMGR,"procmgr"},
	{PID_CORE,"core"}
	
};

int pid_init(int pid)
{
	currentPid = pid;
	
	return 0;
}

char *pidNameGet(int pid)
{
	int i = 0;
	for(i = 0; i < sizeof(pid_table);i++)
	{
		if(pid == pid_table[i].pid)
		{
			return pid_table[i].name;
		}
	}
	
	return NULL;
}