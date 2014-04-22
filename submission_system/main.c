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

#define CONFIG_PATH "config.conf"

int main()
{
    int err;
    config_t *config = config_init(CONFIG_PATH, &err); 
    submission_manager_t *manager = manager_init(config->endpoint);

    if (err == CONFIG_FAILURE)
        printf("An error occured while opening the config.\n");

    submit(manager, "config.conf");

    config_destroy(config);
    exit(EXIT_SUCCESS);
}

