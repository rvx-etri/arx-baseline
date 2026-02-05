#include <time.h>
#include <stdbool.h>
#include <string.h>

#ifdef RUN_ON_HOST_COMP
#include <stdlib.h>
#include "mnist_onnx.h"
#else
#include <ervp_fakefile.h>
#include <ervp_malloc.h>
#include "arx_mnist_onnx.h"
#endif

#include "input.h"
#include "label.h"

#define IMAGES_NUM 5 // The number of images to run

int main(int argc, char** argv) {
    float output[10];
    int image_count = 0;
    int right_answer_count = 0;
    for(int i = 0; i < IMAGES_NUM; i++) {
      main_graph(input[i], output);

      int answer = 0;
      float max_val = output[0];
      for(int j = 0; j < 10; j++) {
        if(output[j] > max_val) {
          max_val = output[j];
          answer = j;
        }
      }
      if(answer == label[i]) {
          image_count++;
          right_answer_count++;
      } else {
          image_count++;
      }
      // printf("(image %d) label: %d | answer: %d | accuracy: %.4f\n", image_count, label[i], answer, (float) right_answer_count / image_count);
      printf("(image %d) label: %d | answer: %d\n", image_count, label[i], answer);
#if 0
    for (int i = 0; i < 10; ++i) {
        printf("%.4f ", output[i]);
    }
    printf("\n");
#endif
    }

    return 0;
}
