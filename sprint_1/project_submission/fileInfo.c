#include <stdio.h>
#include <string.h>
#include "fileInfo.h"

//input: number of command line arguments
//output: number of files submitted OR -1 if not enough arguments
int checkArgs(int argCount) {
	if (argCount < 4) {
		return -1;
		printf("Please use: ./submit course_section assignment_name file1 file2 etc.\n");
	}
	else {
		return (argCount - 3);
	}
}

//input: file name, file count
//output: file size array
void checkFiles(int numFiles, char** fileName, int* sizes) {
	int i;
	for (i = 0; i < numFiles; i++) {
		FILE* in;
		in = fopen(fileName[i+3], "r");
		int size;
		if (!in) {
			sizes[i] = -1;
			printf("File '%s' does not exist.\n", fileName[i+3]);
		} else {
			fseek(in, 0L, SEEK_END);
			size = ftell(in);
			sizes[i] = size;
			printf("File '%s' is %d bytes.\n", fileName[i+3], size);
			fclose(in);	
		}	
	}
}
