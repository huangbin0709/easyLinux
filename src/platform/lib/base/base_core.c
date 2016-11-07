#include <unistd.h>
#include <fcntl.h>

/*进程初始化顶半部*/
int baseInit_th(int pid)
{
	pid_init(pid);
	setup_sigsegv();
	appStartupResp(pid);
	
	return 0;
}

/*进程初始化底半部*/
int baseInit_bh()
{
	
	
	while(1)
	{
		sleep(1);
	}
}