#ifndef CLASSIFIER_H
#define CLASSIFIER_H

#include "texpar_list.h"

#ifdef __cplusplus
extern "C" {
#endif
texpar_list_t *read_data_cfg(char *filename);
#ifdef __cplusplus
}
#endif

void init_network(char *namelistfile, char *cfgfile, char *weightfile);
void predict_wav(float *wav);

#endif
