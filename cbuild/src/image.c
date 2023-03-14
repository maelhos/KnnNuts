#include "image.h"

image image_init(uint8_t img_size){
    image ret = (image)malloc(sizeof(struct _image));
    ret->img_size = img_size;
    ret->buff_size = img_size*img_size;
    ret->buffer = (uint8_t*)malloc(sizeof(uint8_t) * ret->buff_size);
    ret->label = -1;
    return ret;
}