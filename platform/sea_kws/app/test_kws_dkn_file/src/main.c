#include "platform_info.h"
#include "ervp_printf.h"
#include "ervp_multicore_synch.h"
#include "ervp_variable_allocation.h"
#include "ervp_malloc.h"
#include "ervp_core_id.h"

#include "PmodOLED.h"
#include "OledGrph.h"

#include "darknet.h"
#include "classifier.h"

#include "SPTK.h"

volatile Wavfile wavfile;

#define NSAMPLES        (16000)

void wavdisplay_on_oledbw(const Wavfile *wavfile);

int main(int argc, char **argv)
{
  if(EXCLUSIVE_ID==0)
  {
    int key;
    short *wavdata;
    float *fdata;
    int file_samples;

    fdata = (float *)malloc(sizeof(float)*NSAMPLES);

    init_network("kws_name_list", "kws_lms.cfg", "kws_lms.weights");

    while(1)
    {
      printf("select wav file 1~4 (press x for finish)\n");
      while(1)
      {
        key = getc_from_mcom();

        if(key == '1') {
          wavread(&wavfile, "f19d1738_nohash_0_happy.wav");
          break;
        }
        else if(key == '2') {
          wavread(&wavfile, "f8ba7c0e_nohash_0_happy.wav");
          break;
        }
        else if(key == '3') {
          wavread(&wavfile, "f15a354c_nohash_0_wow.wav");
          break;
        }
        else if(key == '4') {
          wavread(&wavfile, "f00180d0_nohash_1_wow.wav");
          break;
        }
        else if(key == 'x') {
          break;
        }
      }
      if(key == 'x') break;

      if((wavfile.channel_num != 1) || (wavfile.sample_freq != 16000) || (wavfile.bit_per_sample != 16))
      {
        print_wav(&wavfile);
        printf("Wav file must be 1 channel, 16000 Hz, 16 bits\n");
        return 0;
      }
      wavdisplay_on_oledbw(&wavfile);
      wavdata = (short *)wavfile.data;
      file_samples = wavfile.data_chunk_size / (wavfile.bit_per_sample / 8);

      for(int k=0; k < NSAMPLES; k++)
      {
        if(k < file_samples)
          fdata[k] = (float)(wavdata[k])/32768;
        else
          fdata[k] = fdata[k%file_samples];
      }
      predict_wav(fdata);

    }
    free(fdata);
    printf("test_kws_dkn app is finished!\n");
  }

  return 0;
}

void wavdisplay_on_oledbw(const Wavfile *wavfile)
{
    OledInit();
    oled_bw_config_spi();
    int file_samples = wavfile->data_chunk_size / (wavfile->bit_per_sample / 8);
    int interval = file_samples / 128;
    short *wavdata = (short *)wavfile->data;
    for(int i=0; i < 127; i++)
    {
      // range [-32768, 32767] to range [0, 31]
      OledMoveTo(i, (int)(wavdata[i*interval]>>10) + 16);
      OledLineTo(i+1, (int)(wavdata[(i+1)*interval]>>10) + 16);
    }
    OledUpdate();
    OledClearBuffer();
}
