#ifndef DF_BUILD_H
#define DF_BUILD_H

#include "debforge.h"

typedef enum {
    DF_BUILD_IDLE,
    DF_BUILD_PREPARE,
    DF_BUILD_LAYOUT,
    DF_BUILD_CONTROL,
    DF_BUILD_SCRIPTS,
    DF_BUILD_PACKAGE,
    DF_BUILD_VALIDATE,
    DF_BUILD_COMPLETE,
    DF_BUILD_FAILED
} df_build_stage_t;

typedef struct {
    char project[DF_MAX_NAME];
    char version[DF_MAX_VERSION];
    char arch[DF_MAX_ARCH];
    char source_path[DF_MAX_PATH];
    char output_path[DF_MAX_PATH];
} df_build_config_t;

typedef struct {
    df_build_stage_t stage;
    df_u64 start_time;
    df_u64 end_time;
    df_i32 result;
    df_error_t error;
} df_build_state_t;

int df_build_init(df_build_config_t *cfg);
int df_build_run(df_build_config_t *cfg, df_build_state_t *state);
int df_build_cancel(void);
int df_build_resume(df_build_state_t *state);

int df_build_layout(const df_build_config_t *cfg);
int df_build_control(const df_build_config_t *cfg);
int df_build_scripts(const df_build_config_t *cfg);
int df_build_package(const df_build_config_t *cfg);
int df_build_validate(const df_build_config_t *cfg);

#endif
