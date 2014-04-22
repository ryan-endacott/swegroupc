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
    return SUBMIT_FAILURE;
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

