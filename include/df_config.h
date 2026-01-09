#ifndef DF_CONFIG_H
#define DF_CONFIG_H

#include "debforge.h"

typedef enum {
    DF_CFG_STRING,
    DF_CFG_INT,
    DF_CFG_BOOL,
    DF_CFG_PATH
} df_config_type_t;

typedef struct {
    char key[128];
    df_config_type_t type;
    union {
        char string[1024];
        df_i64 integer;
        df_i32 boolean;
    } value;
} df_config_entry_t;

typedef struct {
    df_config_entry_t *entries;
    size_t count;
} df_config_t;

int df_config_load(const char *path, df_config_t *cfg);
int df_config_save(const char *path, const df_config_t *cfg);

const char *df_config_get_string(const df_config_t *cfg, const char *key);
df_i64 df_config_get_int(const df_config_t *cfg, const char *key);
df_i32 df_config_get_bool(const df_config_t *cfg, const char *key);

int df_config_set_string(df_config_t *cfg, const char *key, const char *value);
int df_config_set_int(df_config_t *cfg, const char *key, df_i64 value);
int df_config_set_bool(df_config_t *cfg, const char *key, df_i32 value);

void df_config_free(df_config_t *cfg);

#endif
