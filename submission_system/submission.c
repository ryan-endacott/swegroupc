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
int submit(submission_manager_t *manager, const char *file_path)
{
    // Initialize the curl transfer manager and open a file descriptor.
    CURL *curl = curl_easy_init();
    FILE *fd = fopen(file_path, "r");

    // Verify that the file was opened.
    if (fd == NULL)
    {
        curl_easy_cleanup(curl);
        return SUBMIT_FAILURE;
    }

    // Prepare curl for upload.
    curl_easy_setopt(curl, CURLOPT_URL, manager->endpoint);
    curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
    curl_easy_setopt(curl, CURLOPT_READDATA, fd);
    
    // Perform the upload.
    CURLcode code = curl_easy_perform(curl);

    // Cleanup since we're done with curl.
    curl_easy_cleanup(curl);

    // Verify the submission's success.
    if (code != CURLE_OK) return SUBMIT_FAILURE;
    
    // Return with a success.
    return SUBMIT_SUCCESS;
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

/**
 * Submits an entire folder denoted by a given path.
 *
 * Returns SUBMIT_SUCCESS if the operation was successful.
 * Otherwise, returns SUBMIT_FAILURE.
 */
int submit_folder(submission_manager_t *manager, const char *folder_path)
{
    return SUBMIT_FAILURE;
}

