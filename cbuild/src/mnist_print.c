#include "mnist_print.h"

uint32_t isqrt(uint32_t n){
    uint32_t x = n;
    uint32_t y  = (x + 1) / 2;
    while (y < x){
        x = y;
        y = (y + n / x) / 2;
    }
    return x;
}

int map(int32_t i, int32_t r1, int32_t r2){
    return (int)( (float)r2 * (float)i / (float)r1);
}

void mnist_print(int32_t* img, uint32_t size){
    uint32_t side = isqrt(size);
    assert(side * side == size);
    for (uint32_t i = 0; i < side; i++){
        for (uint32_t j = 0; j < side; j++)
            printf("%c", ASCII_grayscale[map(img[i * side + j], 256, 70)]);
        if (i != side - 1) printf("\n");
    }
}