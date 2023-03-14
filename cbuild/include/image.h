#pragma once
#include "stdinc.h"

struct _image {
    uint8_t* buffer;
    uint8_t img_size; // 28 in this case
    uint16_t buff_size; // if image is 28x28 it will be 784
    int8_t label; // -1 is unset by default
};
typedef struct _image* image;

#define IMAGE_XY(img, x, y) ((img)->buffer[((x) + ((img)->img_size * (y)))])
image image_init(uint8_t img_size);
