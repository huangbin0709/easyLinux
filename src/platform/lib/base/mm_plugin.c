

int mm_load_plugin(int mid,MM_PLUGIN_FUNC*func,unsigned char bCoreFirst)
{
#if 0
	if(currentPid == PID_CORE)
	{
		if(bCoreFirst)
		{
			if(NULL != func)
			{
				func();
			}
			mm_setState(mid,MM_BEGIN);
			mm_wait(mid,MM_END);
		}
		else
		{
			mm_setState(mid,MM_BEGIN);
			mm_wait(mid,MM_END);	
			if(NULL != func)
			{
				func();
			}			
		}
	}
	else
	{
		mm_wait(mid,MM_BEGIN);
		if(NULL != func)
		{
			func();
		}
		mm_setState(mid,MM_END);
	}
#endif
	return 0;
}