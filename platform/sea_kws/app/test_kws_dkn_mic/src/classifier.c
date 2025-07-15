#include "platform_info.h"
#include "ervp_printf.h"
#include "ervp_malloc.h"
#include "ervp_profiling.h"
#include "ervp_fakefile.h"
#include "ervp_delay.h"

#include "network.h"
#include "utils.h"
#include "parser.h"
#include "blas.h"
#include "assert.h"
#include "classifier.h"
//#include <sys/time.h>

#include "SPTK.h"

#define DCC             (12)
#define NMFB            (40)
#define WSIZE           (640)
#define WSTRIDE         (320)
#define FFTSIZE         (512)
#define NSAMPLES        (16000)
#define NFRAME          (((NSAMPLES - WSIZE)/WSTRIDE) + 1)
#define FS              (16000)

#define USE_LOG_MEL_SPECTRUM


volatile int classes;
volatile network net;
volatile char *names[100];

void init_network(char *namelistfile, char *cfgfile, char *weightfile)
{
  profiling_start("init");
  net = parse_network_cfg_custom(cfgfile, 1, 0);
  if(weightfile){
    load_weights(&net, weightfile);
  }
  set_batch_network(&net, 1);

  fuse_conv_batchnorm(net);
  calculate_binary_weights(net);

  char *line;
  int classes_count = 0;
  FAKEFILE *fp = ffopen(namelistfile, "r");
  while(line = ffgetline(fp))
  {
    names[classes_count] = line;
    classes_count++;
  }
  ffclose(fp);
  classes = classes_count;
  profiling_end("init");

  profiling_start("init_feature");
  init_window(HAMMING, WSIZE, 0);
  init_mel_filter_banks(FS, FFTSIZE, NMFB);
  profiling_end("init_feature");
}

void predict_wav(float *wav)
{
  int i = 0;
  int* indexes = (int*)calloc(classes, sizeof(int));
  float *X = malloc(sizeof(float)*net.w*net.h);

#ifdef USE_LOG_MEL_SPECTRUM
  profiling_start("get_log_mel_spectrum");
  get_log_mel_spectrum(wav, NSAMPLES, X, FS, WSIZE, WSTRIDE, FFTSIZE, NMFB);
  profiling_end("get_log_mel_spectrum");
  //return;
#else
  profiling_start("get_mfcc");
  get_mfcc(wav, NSAMPLES, X, FS, WSIZE, WSTRIDE, FFTSIZE, DCC, NMFB);
  profiling_end("get_mfcc");
#endif
#if 0
  printf("%f\n", X[0]);
  printf("%f\n", X[1]);
  printf("%f\n", X[2]);
  printf("%f\n", X[3]);
  printf("%f\n", X[NFRAME*DCC-4]);
  printf("%f\n", X[NFRAME*DCC-3]);
  printf("%f\n", X[NFRAME*DCC-2]);
  printf("%f\n", X[NFRAME*DCC-1]);
#endif
  profiling_start("network_predict");
  float *predictions = network_predict(net, X);
  profiling_end("network_predict");
  if(net.hierarchy) hierarchy_predictions(predictions, net.outputs, net.hierarchy, 0);
#if 0
  for(i = 0; i < classes; ++i){
    if(net.hierarchy) printf("%d, %s: %f, parent: %s \n",i, names[i], predictions[i], (net.hierarchy->parent[i] >= 0) ? names[net.hierarchy->parent[i]] : "Root");
    else printf("%s: %f\n",names[i], predictions[i]);
  }
#else
  top_k(predictions, net.outputs, classes, indexes);
  for(i = 0; i < classes; ++i){
    int index = indexes[i];
    if(net.hierarchy) printf("%d, %s: %f, parent: %s \n",index, names[index], predictions[index], (net.hierarchy->parent[index] >= 0) ? names[net.hierarchy->parent[index]] : "Root");
    else printf("%s: %f\n",names[index], predictions[index]);
  }
#endif
  free(X);
  free(indexes);
}
