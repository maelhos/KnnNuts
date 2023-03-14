#include "stdinc.h"
#include "mnist_parse.h"
#include "mnist_print.h"

int main(int argc, char* argv[]){
    idx train_images = mnist_open_in(DATA_TRAIN_IMG);
    idx train_label = mnist_open_in(DATA_TRAIN_LABEL);
    idx test_images = mnist_open_in(DATA_TEST_IMG);
    idx test_label = mnist_open_in(DATA_TEST_LABEL);

    printf("dimensions: %d\n", train_images->dimensions);
    printf("dim0: %d\n", train_images->dim0_size);
    printf("datasize: %d\n", train_images->datatype);
    for (uint32_t i = 0; i < train_images->dimensions; i++)
    {
        printf("%d\n", train_images->size[i]);
    }
    
    if (argc == 2){
        char *end;
        uint32_t index  = strtol(argv[1], &end, 10);
        
        int32_t* image = mnist_get(train_images, index);
        int32_t number = mnist_get(train_label, index)[0];

        mnist_print(image, train_images->dim0_size);
        printf("Label: %d\n", number);
    }
    return 0;
}