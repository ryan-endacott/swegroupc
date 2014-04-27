/**
 * submission.h
 * Author: Software Engineering Group C
 *
 * Description:
 *      Encapsulates the logic for file submissions into a library.
 */

#ifndef SUBMISSION_H_
#define SUBMISSION_H_

#define SUBMIT_SUCCESS 1
#define SUBMIT_FAILURE 0

typedef struct submission_manager {
    char *endpoint;
} submission_manager_t;

/**
 * Initializes the manager with a given endpoint.
 */
submission_manager_t *manager_init(const char *endpoint);

/**
 * Destroys the manager and any associated resources.
 */
void manager_destroy(submission_manager_t *manager);

/**
 * Submits a file denoted by a given path.
 *
 * Returns SUBMIT_SUCCESS if the operation was successful.
 * Otherwise, returns SUBMIT_FAILURE.
 */
int submit(submission_manager_t *manager, const char *file_path);

/**
 * Submits many files denoted by an array of paths.
 *
 * Returns SUBMIT_SUCCESS if the operation was successful.
 * Otherwise, returns SUBMIT_FAILURE.
 */
int submit_many(submission_manager_t *manager, const char *file_paths[]);

char* tarFiles(char** fileName, int count, char* pawprint);

#endif
