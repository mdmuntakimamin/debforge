#ifndef DEBFORGE_H
#define DEBFORGE_H

#include <stdint.h>
#include <stddef.h>
#include <unistd.h>

#define DF_OK 0
#define DF_ERR -1
#define DF_TRUE 1
#define DF_FALSE 0

#define DF_MAX_PATH 4096
#define DF_MAX_NAME 256
#define DF_MAX_VERSION 128
#define DF_MAX_ARCH 64

typedef uint8_t df_u8;
typedef uint16_t df_u16;
typedef uint32_t df_u32;
typedef uint64_t df_u64;
typedef int8_t df_i8;
typedef int16_t df_i16;
typedef int32_t df_i32;
typedef int64_t df_i64;

typedef enum {
    DF_LOG_TRACE,
    DF_LOG_DEBUG,
    DF_LOG_INFO,
    DF_LOG_WARN,
    DF_LOG_ERROR,
    DF_LOG_FATAL
} df_log_level_t;

typedef struct {
    df_i32 code;
    char message[1024];
} df_error_t;

typedef struct {
    df_u64 timestamp;
    df_log_level_t level;
    char component[64];
    char message[1024];
} df_log_entry_t;

int df_init(void);
void df_shutdown(void);

const char *df_version(void);
const char *df_arch(void);

void df_set_log_level(df_log_level_t level);
void df_log(df_log_level_t level, const char *component, const char *fmt, ...);

int df_path_exists(const char *path);
int df_is_dir(const char *path);
int df_is_file(const char *path);

ssize_t df_read_file(const char *path, void *buf, size_t len);
ssize_t df_write_file(const char *path, const void *buf, size_t len);

#endif
