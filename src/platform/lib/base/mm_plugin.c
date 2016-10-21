

int mm_load_plugin(int mid,int (*module_init)(void),unsigned char bCoreFirst)
{
#if 0
	if(currentPid == PID_CORE)
	{
		if(bCoreFirst)
		{
			if(NULL != module_init)
			{
				module_init();
			}
			mm_setstate(mid,MM_BEGIN);
			mm_wait(mid,MM_END);
		}
		else
		{
			mm_setstate(mid,MM_BEGIN);
			mm_wait(mid,MM_END);	
			if(NULL != module_init)
			{
				module_init();
			}			
		}
	}
	else
	{
		mm_wait(mid,MM_BEGIN);
		if(NULL != module_init)
		{
			module_init();
		}
		mm_setstate(mid,MM_END);
	}
#endif
	return 0;
}