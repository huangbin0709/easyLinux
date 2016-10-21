#ifndef __PID_H_
#define __PID_H_

extern int currentPid;

enum {
	PID_NONE,
	PID_PROCMGR,
	PID_CORE,
	
	PID_END
};

typedef struct{
	int pid;
	char *name;
}pidw_t;

char *pidNameGet(int pid);
#endif