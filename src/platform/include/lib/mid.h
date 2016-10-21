#ifndef __MID_H_
#define __MID_H_

enum {
	MID_NONE,
	MID_SYSMANAGE,
	
	MID_END
};

typedef struct{
	int mid;
	char *name;
}mid_t;

char *midNameGet(int mid);
#endif