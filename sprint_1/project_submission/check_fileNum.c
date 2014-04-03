#include <stdio.h>

int main(int argc, char* argv[])
{
	if(argc<5){
	   //./a.out is included
	   printf("No enough input element\n");
	   return 0;
	}
	int i;
	int sz;
	for(i=4;i<argc+1;i++){
		sz=verifyFile(argv[i]);
		if(sz=-1){
			printf("File not existing.\n");
		}
		else{
			printf("File size is %d",sz);
		}
	}
	return 0;
}	