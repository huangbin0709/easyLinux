#include <unistd.h>
#include <fcntl.h>

/*���̳�ʼ�����벿*/
int baseInit_th(int pid)
{
	pid_init(pid);
	setup_sigsegv();
	appStartupResp(pid);
	
	return 0;
}

/*���̳�ʼ���װ벿*/
int baseInit_bh()
{
	
	
	while(1)
	{
		sleep(1);
	}
}