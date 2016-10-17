#ifndef __PROCMGR_H_
#define __PROCMGR_H_

#define EASYLINUX_EXE_PATH "/easylinux/app/bin"

void* procmgr_collector(void *arg);
int procmgrStartUpProcess(char *bin_name,char *name);
#endif