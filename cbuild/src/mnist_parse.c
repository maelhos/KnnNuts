#include "mnist_parse.h"

idx mnist_open_in(const char filename[]){
   return mnist_of_channel(fopen(filename, "rb"));
}

idx mnist_of_channel(FILE* f){
    assert(f);
    idx ret = (idx)malloc(sizeof(struct _idx));
    ret->file = f;
    assert(!fseek(f, 0, SEEK_SET));
    fgetc(f);
    fgetc(f);
    char fc = (char)fgetc(f);
    ret->formater[0] = '%';
    switch (fc){
    case '\x08':
        ret->datatype = sizeof(uint8_t);
        ret->formater[1] = 'c';
        break;
    case '\x09':
        ret->datatype = sizeof(int8_t);
        ret->formater[1] = 'c';
        break;
    case '\x0B':
        ret->datatype = sizeof(int16_t);
        ret->formater[1] = 'h';
        break;
    case '\x0C':
        ret->datatype = sizeof(int32_t);
        ret->formater[1] = 'd';
        break;
    default:
        printf("Error reading mnist file, datatype unmatched : 0x0%hhxx\n", fc);
        exit(1);
        break;
    }
    ret->dimensions = (uint32_t)fgetc(f);
    ret->size = (uint32_t*)malloc(sizeof(uint32_t) * ret->dimensions);
    for (uint32_t i = 0; i < ret->dimensions; i++)
        fscanf(f, "%d", &ret->size[i]);
    ret->dim0_size = 1;
    for (uint32_t i = 1; i < ret->dimensions; i++)
        ret->dim0_size *= ret->size[i];
    return ret;
}

int32_t* mnist_get(idx id, uint32_t pos){
    fseek(id->file, sizeof(int32_t) + sizeof(int32_t) * id->dimensions +
                        pos * id->dim0_size * id->datatype, SEEK_SET);
                
    int32_t* ret = (int32_t*)malloc(sizeof(int32_t) * id->dim0_size);
    for (uint32_t i = 0; i < id->dim0_size; i++)
        assert(fscanf(id->file, id->formater, ret + i));
    return ret;
}