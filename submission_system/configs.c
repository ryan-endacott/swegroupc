#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "configs.h"

//input: none
//output: student's pawprint
char* getStuInfo() {
	char *username = getenv("USER");
    if(username == NULL)
		return EXIT_FAILURE;   
    return username;
}
