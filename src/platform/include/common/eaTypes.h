#ifndef __EATYPES_H_
#define __EATYPES_H_

#define TRUE          (1)
#define FALSE         (0)
#define OK            (0)
#define ERROR         (-1)

typedef unsigned char UINT8;
typedef unsigned short UINT16;
typedef unsigned int UINT32;
typedef unsigned char BOOL;

enum {
	ERR_NO_ERROR = 0,
	ERR_BAD_PARAM,
	ERR_NONE
};
#endif