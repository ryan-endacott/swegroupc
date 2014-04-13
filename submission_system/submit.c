#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "fileInfo.h"
#include "configs.h"
 
int main(int argc, char** argv) {
	
	//checks that proper num of arguments were entered and gets num of files submitted
	int numFiles = checkArgs(argc);
	if (numFiles == -1)
		return 1;

	//gets course section and assignment
	char* courseSec = argv[1];
	char* assignment = argv[2];
	
	//checks if files submitted exists and stores their size in array
	int fileSizes[numFiles];
	int checkF = checkFiles(numFiles, argv, fileSizes);
	if(checkF == 1) {
		return 2;
	}
	
	//gets student's pawprint
	char* pawprint = getStuInfo();
	printf("%s\n", pawprint);	
}
