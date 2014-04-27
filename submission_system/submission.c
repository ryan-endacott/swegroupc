/**
 * submission.c
 * Author: Software Engineering Group C
 *
 * Description:
 *      The implementation of the submission logic defined
 *      in submission.h
 */

#include <string.h>
#include <stdlib.h>
#include <curl/curl.h>
#include "submission.h"
#include "lib/cJSON.h"

/**
 * Initializes the manager with a given endpoint.
 */
submission_manager_t *manager_init(const char *endpoint)
{
    // Allocate room for the manager.
    submission_manager_t *manager =
        (submission_manager_t *) malloc(sizeof(submission_manager_t)); 
    
    // Determine the endpoint string's length and malloc room for it
    // in the manager.
    size_t endpoint_length = strlen(endpoint) + 1;
    manager->endpoint = (char *) malloc(endpoint_length);

    // Copy the endpoint in.
    strcpy(manager->endpoint, endpoint);

    // Return the freshly allocated manager.
    return manager;
}

/**
 * Destroys the manager and any associated resources.
 */
void manager_destroy(submission_manager_t *manager)
{
    free(manager->endpoint);
    free(manager);
}

/**
 * Submits a file denoted by a given path.
 *
 * Returns SUBMIT_SUCCESS if the operation was successful.
 * Otherwise, returns SUBMIT_FAILURE.
 */
int submit(submission_manager_t *manager, const char *assignmentName, const char *courseName, const char *sectionName, const char *file_path, const char *pawprint)
{
    // Prepare curl for a multipart http post.
    CURL *curl = curl_easy_init();
    struct curl_httppost *post = NULL;
    struct curl_httppost *last = NULL;
    
    // Add the fields.
    curl_formadd(&post, &last,
            CURLFORM_COPYNAME, "submission[assignment_name]",
            CURLFORM_COPYCONTENTS, assignmentName,
            CURLFORM_CONTENTTYPE, "text",
            CURLFORM_END);
	curl_formadd(&post, &last,
            CURLFORM_COPYNAME, "submission[course_name]",
            CURLFORM_COPYCONTENTS, courseName,
            CURLFORM_CONTENTTYPE, "text",
            CURLFORM_END);
     curl_formadd(&post, &last,
            CURLFORM_COPYNAME, "submission[section_name]",
            CURLFORM_COPYCONTENTS, sectionName,
            CURLFORM_CONTENTTYPE, "text",
            CURLFORM_END);
	curl_formadd(&post, &last,
            CURLFORM_COPYNAME, "submission[file][]",
            CURLFORM_FILE, file_path,
            CURLFORM_CONTENTTYPE, "file",
            CURLFORM_END);
	curl_formadd(&post, &last,
            CURLFORM_COPYNAME, "pawprint",
            CURLFORM_COPYCONTENTS, pawprint,
            CURLFORM_CONTENTTYPE, "text",
            CURLFORM_END);
	curl_formadd(&post, &last,
            CURLFORM_COPYNAME, "password",
            CURLFORM_COPYCONTENTS, "hi",
            CURLFORM_CONTENTTYPE, "text",
            CURLFORM_END);

    // Define where it's going.
    curl_easy_setopt(curl, CURLOPT_URL, manager->endpoint);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, jsonResponse);
    curl_easy_setopt(curl, CURLOPT_HTTPPOST, post);

    // Perform and handle the return value.
    CURLcode res = curl_easy_perform(curl);
    int return_val;

    if (res != CURLE_OK)
        return_val = SUBMIT_FAILURE;
    else
        return_val = SUBMIT_SUCCESS;
    
    // Cleanup curl.
    curl_easy_cleanup(curl);
    
    // Return the return value.
    return return_val;
}

//gets response from server in JSON format, parses it and logs the receipt or error and shows it to user
size_t jsonResponse(char *ptr, size_t size, size_t nmemb, void *userdata) {
	
	cJSON *root = cJSON_Parse(ptr);
	
	//gets the first element
	cJSON *childElem = cJSON_GetArrayItem(root, 0);
	if (childElem->string == "error") {
		printf("ERROR: %s\n", childElem->valuestring);
		//writes error/receipt to temp file for access by logging function
		//this is probably not the best way to do this, but I didn't see anything in the libCurl docs
		//about passing custom values into the CURLOPT_WRITEFUNCTION
		FILE* temp = fopen("___temp.txt", "w+");
		fprintf(temp, "ERROR: %s\n", childElem->valuestring);
		fclose(temp);
	} else {
		printf("RECEIPT: %s\n", childElem->valuestring);
		FILE* temp = fopen("___temp.txt", "w+");
		fprintf(temp, "RECEIPT: %s\n", childElem->valuestring);
		fclose(temp);
	}
	
	cJSON_Delete(root);
	
	//returns bytes written so curl doesn't see it as error
	return nmemb * size;
}

/**
 * Submits many files denoted by an array of paths.
 *
 * Returns SUBMIT_SUCCESS if the operation was successful.
 * Otherwise, returns SUBMIT_FAILURE.
 */
int submit_many(submission_manager_t *manager, const char *file_paths[])
{
    return SUBMIT_FAILURE;
}

//compresses submitted files into tarball
char* tarFiles(char** fileName, int count, char* pawprint) {
	
	FILE* proc;
	char command[1000000];
	char files[1000000];
	
	//appends file names to command to execute
	int i = 0;
	strcpy(files, fileName[i+4]);
	for (i = 1; i < count; i++) {
		strcat(files, " ");
		strcat(files,fileName[i+4]);		
	}
	
	char outName[1000000];
	strcpy(outName, pawprint);
	strcat(outName, "_");
	strcat(outName, fileName[1]);
	strcat(outName, "_");
	strcat(outName, fileName[2]);
	strcat(outName, "_");
	strcat(outName, fileName[3]);
	strcat(outName, ".tar");
	
	int len;
	len = snprintf(command, sizeof(command), "tar -cf %s %s", outName, files);
	if (len <= sizeof(command)) {
		proc = popen(command, "r");
	} else {
		printf("too long\n");
		return NULL;
	}
	pclose(proc);
	
	return outName;
}

