#include <stdio.h>

int verifyFile(char* filename){
	FILE* in;
    in=fopen(filename,"r");
	int sz;
    if(in==NULL){
       return -1;
    }else{
       fseek(in, 0L, SEEK_END);
	   sz = ftell(in);
	   return sz;
   }
}