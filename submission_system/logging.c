#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "logging.h"

//input: none
//output: student's pawprint
char* getStuInfo() {
	char* username = getenv("USER"); 
    return username;
}

//input: pawprint, files array
//output: log file with pawprint, ip, files and sizes, and time
char* initialLog(char* pawprint, int* sizes, int numFiles, char** fileNames) {
	//gets current time in calendar and epoch format
	time_t rawtime;
	struct tm * timeinfo;
	time ( &rawtime );
	timeinfo = localtime ( &rawtime );
	rawtime = (int)time(NULL);
	
	//gets ip address
	FILE* command;
	char path[1035];	
	command = popen("ifconfig | grep inet", "r");
	
	
	//creates log file based on pawprint and timestamp
	char epochTime[100];
	sprintf(epochTime, "%d", rawtime);
	char logName[250];
	strcpy(logName, pawprint);
	strcat(logName, "-");
	strcat(logName, epochTime);
	strcat(logName, ".txt");
	FILE* log = fopen(logName, "w+");
	
	//writes pawprint, submission time, IP address, file sizes and file names to log file
	fprintf(log, "PAWPRINT: %s\n", pawprint);
	fprintf(log, "TIME: %s\n", asctime (timeinfo));
	fprintf(log, "IP ADDRESS: \n");
	while (fgets(path, sizeof(path)-1, command) != NULL) {
		fprintf(log, "%s", path);
	}
	pclose(command);
	fprintf(log, "FILES: \n");
	int i;
	for (i = 0; i < numFiles; i++) {
		fprintf(log, "\t%s : %d bytes\n", fileNames[i+4], sizes[i]);
	}
	
	fclose(log);
	
	return logName;
}
