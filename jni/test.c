#include <jni.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int printInterface();
int printB();

char str[1000];


int printInterface(){    
    sprintf(str, "%sA\n", str);
}
int printB(){ 
    sprintf(str, "%sB\n", str);
}

jstring
Java_com_test_test_test_resultFromJNI(JNIEnv* env, jobject thiz)
{
    
	unsigned int* _printInterface;
    unsigned int __printInterface = (unsigned int) &printInterface;   
   	_printInterface = (unsigned int*)(__printInterface);     	
   	

	strcpy(str,"");
	printB();
    printInterface();
    ((unsigned int*)((unsigned int) &printInterface))[0] = 0xe51ff004;
    ((unsigned int*)((unsigned int) &printInterface))[1] = (unsigned int) &printB;
    printInterface();
        
    return (*env)->NewStringUTF(env, str);
}
