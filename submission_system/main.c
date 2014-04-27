/**
 * main.c
 * Author: Software Engineering Group C
 *
 * Description:
 *      The command line application that handles file submission
 *      to the web service.
 *
 *      Implementation is dependent upon libcurl for transfers.
 */

#include <stdio.h>
#include <stdlib.h>
#include "submission.h"
#include "config.h"
#include "fileInfo.h"
#include "logging.h"
#include "lib/cJSON.h"

#define CONFIG_PATH "config.conf"

int main(int argc, char** argv)
{
	//checks that proper num of arguments were entered and gets num of files submitted
	int numFiles = checkArgs(argc);
	if (numFiles == -1)
		return 1;

	//gets course section and assignment
	char* courseName = argv[1];
	char* courseSec = argv[2];
	char* assignment = argv[3];
	
	//checks if files submitted exists and stores their size in array
	int fileSizes[numFiles];
	int checkF = checkFiles(numFiles, argv, fileSizes);
	if(checkF == -1) {
		return 2;
	}
	
	//gets student's pawprint
	char* pawprint = getStuInfo();

	//logs info about submission
	char* logFile = initialLog(pawprint, fileSizes, numFiles, argv);
	
	//compresses files into tarball
	char* tarFileName = tarFiles(argv, numFiles, pawprint);
		
	//submission
    int err;
    config_t *config = config_init(CONFIG_PATH, &err); 
    submission_manager_t *manager = manager_init(config->endpoint);

    if (err == CONFIG_FAILURE)
        printf("An error occured while opening the config.\n");

    submit(manager, assignment, courseName, courseSec, tarFileName, pawprint);

    config_destroy(config);
    exit(EXIT_SUCCESS);
    
    //does final logging
    finalLog(logFile);
}

