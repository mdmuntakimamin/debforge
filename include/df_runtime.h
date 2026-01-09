#ifndef DF_RUNTIME_H
#define DF_RUNTIME_H

#include "debforge.h"

typedef enum {
    DF_RUN_IDLE,
    DF_RUN_STARTING,
    DF_RUN_RUNNING,
    DF_RUN_FINISHED,
    DF_RUN_FAILED
} df_run_state_t;

typedef struct {
    char package[DF_MAX_NAME];
    char executable[DF_MAX_PATH];
    char workdir[DF_MAX_PATH];
    char stdout_path[DF_MAX_PATH];
    char stderr_path[DF_MAX_PATH];
} df_run_config_t;

typedef struct {
    df_run_state_t state;
    pid_t pid;
    df_u64 start_time;
    df_u64 end_time;
    df_i32 exit_code;
    df_error_t error;
} df_run_info_t;

int df_runtime_prepare(const df_run_config_t *cfg);
int df_runtime_start(df_run_config_t *cfg, df_run_info_t *info);
int df_runtime_wait(df_run_info_t *info);
int df_runtime_kill(df_run_info_t *info);
int df_runtime_cleanup(df_run_config_t *cfg);

#endif
