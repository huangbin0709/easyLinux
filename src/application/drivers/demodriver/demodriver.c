#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

int __init exam_init(void)
{
	return 0;
}

void __exit exam_exit(void)
{
	
}

module_init(exam_init);
module_exit(exam_exit);