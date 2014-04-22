/**
 * config.c
 * Author: Software Engineering Group C
 *
 * Description:
 *      Contains the implementation for extracting configuration
 *      files from the system.
 */

#include <stdio.h>
#include <ctype.h>
#include "config.h"
#include "lib/lcfg.h"

/**
 * Initializes a config structure by extracting from a given path.
 */
config_t *config_init(const char *config_path, int *status)
{
    *status = CONFIG_OK; // Initialize status to ok

    // Create the context to the config and parse it.
    struct lcfg *conf_context = lcfg_new(config_path);

    // Verify the parsing happened correctly.
    if (lcfg_parse(conf_context) != lcfg_status_ok)
    {
        *status = CONFIG_FAILURE;
        return NULL;
    }

    // Allocate memory for the config.
    config_t *config = (config_t *) malloc(sizeof(config_t));
    config->endpoint = (char *) malloc(CONFIG_MAX_ENDPOINT_SIZE * sizeof(char));

    // Pull out the endpoint.
    size_t len;
    if (lcfg_value_get(conf_context, "endpoint", (void **)&(config->endpoint), &len)
            != lcfg_status_ok)
    {
        *status = CONFIG_FAILURE;
        config_destroy(config);
        return NULL;
    }

    size_t i;
    char *string = (char *)*output;
    for (i = 0; i < len; i++)
    {
        printf("%c", string[i]);
    }

    printf("\n");

    // Must've been successful, so return the config.
    return config;
}

/**
 * Destroys a config structure.
 *
 * Should be the last thing done to a config.
 */
void config_destroy(config_t *config)
{
    free(config->endpoint);
    free(config);
}

