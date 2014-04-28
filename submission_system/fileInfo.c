#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "fileInfo.h"

//input: number of command line arguments
//output: number of files submitted OR -1 if not enough arguments
int checkArgs(int argCount) {
	if (argCount < 5) {
		printf("Please use: ./submit course_name course_section assignment_name file1 file2 file...\n");
		return -1;
	}
	else {
		return (argCount - 4);
	}
}

//input: file name, file count
//output: file size array
int checkFiles(int numFiles, char** fileName, int* sizes) {
	int i;
	for (i = 0; i < numFiles; i++) {
		FILE* in;
		in = fopen(fileName[i+4], "r");
		int size;
		if (!in) {
			sizes[i] = -1;
			printf("File '%s' does not exist.\n", fileName[i+4]);
			return -1;
		} else {
			fseek(in, 0L, SEEK_END);
			size = ftell(in);
			
			//checks if file is greater than 5MB
			if (size > 5243000) {
				printf("File '%s' is greater than 5MB\n", fileName[i+4]);
				return -1;
			}
			
			sizes[i] = size;
			fclose(in);	
		}	
	}
	return 0;
}
