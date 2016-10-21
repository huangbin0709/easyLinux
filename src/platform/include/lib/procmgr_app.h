#ifndef __LIBPROCMGR_H_
#define __LIBPROCMGR_H_

int app_retarget_output(void);

int appStartupResp(int pid);

void setup_sigsegv(void);
#endif