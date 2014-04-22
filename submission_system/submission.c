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


