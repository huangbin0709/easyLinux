#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include "lib/pid.h"
#ifndef _GNU_SOURCE  
#define _GNU_SOURCE  
#endif  
#include <dlfcn.h>  
#include <stdlib.h>  
#include <signal.h>  
#include <unistd.h>  
#include <string.h>  
#include <ucontext.h>  
  
/* 纯C环境下，不定义宏NO_CPP_DEMANGLE */  
#if (!defined(__cplusplus)) && (!defined(NO_CPP_DEMANGLE))  
#define NO_CPP_DEMANGLE  
#endif  
  
#ifndef NO_CPP_DEMANGLE  
    #include <cxxabi.h>  
    #ifdef __cplusplus  
        using __cxxabiv1::__cxa_demangle;  
    #endif  
#endif  
  
#ifdef HAS_ULSLIB  
    #include <uls/logger.h>  
    #define sigsegv_outp(x) sigsegv_outp(, gx)  
#else  
    #define sigsegv_outp(x, ...)    fprintf(stderr, x"\n", ##__VA_ARGS__)  
#endif  
  
#if (defined __x86_64__)  
    #define REGFORMAT   "%016lx"      
#elif (defined __i386__)  
    #define REGFORMAT   "%08x"  
#elif (defined __arm__)  
    #define REGFORMAT   "%lx"  
#endif  

typedef struct {
               const char *dli_fname;  /* Pathname of shared object that
                                          contains address */
               void       *dli_fbase;  /* Base address at which shared
                                          object is loaded */
               const char *dli_sname;  /* Name of symbol whose definition
                                          overlaps addr */
               void       *dli_saddr;  /* Exact address of symbol named
                                          in dli_sname */
           } Dl_info;
		   
static void print_reg(ucontext_t *uc)   
{  
#if (defined __x86_64__) || (defined __i386__)  
    int i;  
    for (i = 0; i < NGREG; i++) {  
        sigsegv_outp("reg[%02d]: 0x"REGFORMAT, i, uc->uc_mcontext.gregs[i]);  
    }  
#elif (defined __arm__)  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 0, uc->uc_mcontext.arm_r0);  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 1, uc->uc_mcontext.arm_r1);  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 2, uc->uc_mcontext.arm_r2);  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 3, uc->uc_mcontext.arm_r3);  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 4, uc->uc_mcontext.arm_r4);  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 5, uc->uc_mcontext.arm_r5);  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 6, uc->uc_mcontext.arm_r6);  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 7, uc->uc_mcontext.arm_r7);  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 8, uc->uc_mcontext.arm_r8);  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 9, uc->uc_mcontext.arm_r9);  
    sigsegv_outp("reg[%02d]     = 0x"REGFORMAT, 10, uc->uc_mcontext.arm_r10);  
    sigsegv_outp("FP        = 0x"REGFORMAT, uc->uc_mcontext.arm_fp);  
    sigsegv_outp("IP        = 0x"REGFORMAT, uc->uc_mcontext.arm_ip);  
    sigsegv_outp("SP        = 0x"REGFORMAT, uc->uc_mcontext.arm_sp);  
    sigsegv_outp("LR        = 0x"REGFORMAT, uc->uc_mcontext.arm_lr);  
    sigsegv_outp("PC        = 0x"REGFORMAT, uc->uc_mcontext.arm_pc);  
    sigsegv_outp("CPSR      = 0x"REGFORMAT, uc->uc_mcontext.arm_cpsr);  
    sigsegv_outp("Fault Address = 0x"REGFORMAT, uc->uc_mcontext.fault_address);  
    sigsegv_outp("Trap no       = 0x"REGFORMAT, uc->uc_mcontext.trap_no);  
    sigsegv_outp("Err Code  = 0x"REGFORMAT, uc->uc_mcontext.error_code);  
    sigsegv_outp("Old Mask  = 0x"REGFORMAT, uc->uc_mcontext.oldmask);  
#endif  
}  
  
static void print_call_link(ucontext_t *uc)   
{  
    int i = 0;  
	//int ret = 0;
    void **frame_pointer = (void **)NULL;  
    void *return_address = NULL;  
    Dl_info dl_info = { 0 };  
    int *stackEnd = NULL;
	char cmd[50]={0};
	char buf[512]={0};
	FILE *in = NULL;
#if (defined __i386__)  
    frame_pointer = (void **)uc->uc_mcontext.gregs[REG_EBP];  
    return_address = (void *)uc->uc_mcontext.gregs[REG_EIP];  
#elif (defined __x86_64__)  
    frame_pointer = (void **)uc->uc_mcontext.gregs[REG_RBP];  
    return_address = (void *)uc->uc_mcontext.gregs[REG_RIP];  
#elif (defined __arm__)  
/* sigcontext_t on ARM: 
        unsigned long trap_no; 
        unsigned long error_code; 
        unsigned long oldmask; 
        unsigned long arm_r0; 
        ... 
        unsigned long arm_r10; 
        unsigned long arm_fp; 
        unsigned long arm_ip; 
        unsigned long arm_sp; 
        unsigned long arm_lr; 
        unsigned long arm_pc; 
        unsigned long arm_cpsr; 
        unsigned long fault_address; 
*/  
    frame_pointer = (void **)uc->uc_mcontext.arm_fp;  
    return_address = (void *)uc->uc_mcontext.arm_pc;  
#endif  
  
    sigsegv_outp("\nStack trace:");  
    while (frame_pointer && return_address) { 
	    memset(&dl_info,0,sizeof(dl_info));
		dladdr(return_address, &dl_info);
        const char *sname = dl_info.dli_sname;    
#ifndef NO_CPP_DEMANGLE  
        int status;  
        char *tmp = __cxa_demangle(sname, NULL, 0, &status);  
        if (status == 0 && tmp) {  
            sname = tmp;  
        }  
#endif  
		/* No: return address <sym-name + offset> (filename) */  
		printf("%02d: %p <%s + %lu> (%s)\r\n", ++i, return_address, sname,   
			(unsigned long)return_address - (unsigned long)dl_info.dli_saddr,   
													dl_info.dli_fname); 
#ifndef NO_CPP_DEMANGLE  
        if (tmp)    free(tmp);  
#endif  
		stackEnd = (int*)frame_pointer;
		/*
        if (dl_info.dli_sname && !strcmp(dl_info.dli_sname, "main")) {  
            break;  
        }  
		*/
        if((unsigned long)frame_pointer <= uc->uc_mcontext.arm_sp)
		{
			break;
		}
	
#if (defined __x86_64__) || (defined __i386__)  
        return_address = frame_pointer[1];  
        frame_pointer = frame_pointer[0];  
#elif (defined __arm__)  
        return_address = frame_pointer[-1];   
        frame_pointer = (void **)frame_pointer[-3];  
#endif  
    }  
	printf("\r\nStack Memory:\r\n"); 
	//printf("stackEnd:%p\r\n",stackEnd);
	for(i = 0; i < 1000; i++)
	{
		if(i != 0 && (i % 4 == 0))
		{
			printf("\r\n");
		}
		if((unsigned long)stackEnd < uc->uc_mcontext.arm_sp)
		{
			break;
		}
		
		printf("%p [%08x]",stackEnd,*stackEnd);
		stackEnd--;	
	}
	printf("\r\nMemory map:\r\n"); 
	sprintf(cmd,"cat /proc/%d/maps",getpid());
	in = popen(cmd,"r");
	if(NULL != in)
	{
		while(fgets(buf,512,in))
		{
			printf("%s\r\n",buf);
		}
		pclose(in);
	}
    printf("----------------------------------end---------------------------------------\r\n");  
}  
  
static void sigsegv_handler(int signo, siginfo_t *info, void *context)  
{  
	char *proc_name = NULL;
	
    if (context) {  
        ucontext_t *uc = (ucontext_t *)context;  
		proc_name=pidNameGet(currentPid);
        if(proc_name)
		{
			printf("----------------------Segmentation Fault----------------------------------\r\n");
			printf("Process %s\r\n",proc_name); 
		}
		else
		{
			sigsegv_outp("Segmentation Fault!");
		}
        sigsegv_outp("info.si_signo = %d", signo);  
        sigsegv_outp("info.si_errno = %d", info->si_errno);  
        sigsegv_outp("info.si_code  = %d (%s)", info->si_code,   
            (info->si_code == SEGV_MAPERR) ? "SEGV_MAPERR" : "SEGV_ACCERR");  
        sigsegv_outp("info.si_addr  = %p\n", info->si_addr);  
  
        print_reg(uc);  
        print_call_link(uc);  
    }  
  
    _exit(0);  
}  
  
#define SETSIG(sa, sig, fun, flags)     \
        do {                            \
            sa.sa_sigaction = fun;      \
            sa.sa_flags = flags;        \
            sigemptyset(&sa.sa_mask);   \
            sigaction(sig, &sa, NULL);  \
        } while(0)  
  
void __attribute((constructor)) setup_sigsegv(void)   
{  
    struct sigaction sa;  
  
    SETSIG(sa, SIGSEGV, sigsegv_handler, SA_SIGINFO);   
#if 0  
    memset(&sa, 0, sizeof(struct sigaction));  
    sa.sa_sigaction = sigsegv_handler;  
    sa.sa_flags = SA_SIGINFO;  
    if (sigaction(SIGSEGV, &sa, NULL) < 0) {  
        perror("sigaction: ");  
    }  
#endif  
}  

int app_retarget_output(void)
{
	int fd = -1;
	
	fd = open("/dev/ttySAC0",O_RDWR);
	if(fd < 0)
	{
		printf("can not open console\r\n");
	}
	dup2(fd,STDOUT_FILENO);
	close(fd);
	
	setvbuf(stdout,NULL, _IONBF,0);
	 
	return 0;
}

int appStartupResp(int pid)
{
	app_retarget_output();
	
}