#include <stdlib.h>

int demo_func(void)
{
	demo_funcA();
	return 0;
}

int demo_funcA()
{
	int *p = NULL;
	int a = 100;
	int b = 1000;
	
	*p = a + b;	
	return 0;
}

int demo_test_coredump(void)
{
	demo_func();
	
	return 0;
}