#pragma once
#include "stdinc.h"
#include "image.h"

struct _idx {
    FILE* file;
    char datatype;
    char formater[2];
    uint32_t dimensions;
    uint32_t* size;
    uint32_t dim0_size;
};
typedef struct _idx* idx;

idx mnist_open_in(const char filename[]);
idx mnist_of_channel(FILE* f);
int32_t* mnist_get(idx id, uint32_t pos);