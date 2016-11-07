#ifndef _BASE_H
#define _BASE_H

#ifdef __cplusplus
extern "C" {
#endif

int baseInit_th(int pid);

int baseInit_bh();

int mm_load_plugin(int mid,int (*module_init)(void),unsigned char bCoreFirst);
#ifdef __cplusplus
}
#endif
#endif