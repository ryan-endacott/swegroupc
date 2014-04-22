/**
 * config.h
 * Author: Software Engineering Group C
 *
 * Description:
 *      Contains the definitions for extracting configuration
 *      files from the system.
 */

#ifndef _CONFIG_H
#define _CONFIG_H

#define CONFIG_OK 1
#define CONFIG_FAILURE 0

#define CONFIG_MAX_ENDPOINT_SIZE 1000

/**
 * Defines the config file as a structure
 */
typedef struct _config_t
{
    char* endpoint;
} config_t;

/**
 * Initializes a config structure by extracting from a given path.
 */
config_t *config_init(const char *config_path, int *status);

/**
 * Destroys a config structure.
 *
 * Should be the last thing done to a config.
 */
void config_destroy(config_t *config);

#endif

