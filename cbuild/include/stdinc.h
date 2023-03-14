#pragma once
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>

#define VERSION "0.0.1"

// gives debug information and timing
#define DEBUG

#define ASCII_grayscale "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,\"^`'. "
#define ASCII_gs_len 70

#define DATA_TRAIN_IMG "data/train-images-idx3-ubyte"
#define DATA_TRAIN_LABEL "data/train-images-idx3-ubyte"

#define DATA_TEST_IMG "data/t10k-images-idx3-ubyte"
#define DATA_TEST_LABEL "data/t10k-labels-idx1-ubyte"

