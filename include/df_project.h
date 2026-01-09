#ifndef DF_PROJECT_H
#define DF_PROJECT_H

#include "debforge.h"
#include "df_config.h"

typedef enum {
    DF_PROJECT_UNKNOWN,
    DF_PROJECT_CLI,
    DF_PROJECT_GUI,
    DF_PROJECT_LIBRARY,
    DF_PROJECT_SERVICE
} df_project_type_t;

typedef struct {
    char name[DF_MAX_NAME];
    char version[DF_MAX_VERSION];
    char maintainer[256];
    char description[1024];
    df_project_type_t type;
    char root_path[DF_MAX_PATH];
    df_config_t config;
} df_project_t;

int df_project_init(df_project_t *proj, const char *path);
int df_project_load(df_project_t *proj);
int df_project_save(const df_project_t *proj);

int df_project_validate(const df_project_t *proj);
int df_project_close(df_project_t *proj);

#endif
