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

/**
 * Submits a file denoted by a given path.
 *
 * Returns SUBMIT_SUCCESS if the operation was successful.
 * Otherwise, returns SUBMIT_FAILURE.
 */
int submit(const char *file_path);

/**
 * Submits many files denoted by an array of paths.
 *
 * Returns SUBMIT_SUCCESS if the operation was successful.
 * Otherwise, returns SUBMIT_FAILURE.
 */
int submit_many(const char *file_paths[]);

/**
 * Submits an entire folder denoted by a given path.
 *
 * Returns SUBMIT_SUCCESS if the operation was successful.
 * Otherwise, returns SUBMIT_FAILURE.
 */
int submit_folder(const char *folder_path);

#endif
