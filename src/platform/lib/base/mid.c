#include "lib/mid.h"
#include <stdlib.h>

static mid_t mid_table[]=
{
	{MID_SYSMANAGE,"sysmanage"}
	
};

char *midNameGet(int mid)
{
	int i = 0;
	for(i = 0; i < sizeof(mid_table);i++)
	{
		if(mid == mid_table[i].mid)
		{
			return mid_table[i].name;
		}
	}
	
	return NULL;
}