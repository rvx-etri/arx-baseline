#include "platform_info.h"
#include "ervp_printf.h"
#include "ervp_core_id.h"

#include "PmodOLED.h"
#include "OledGrph.h"

#include "SPTK.h"

volatile Wavfile wavfile;
volatile Wavfile *user_wavfile;

volatile Wavfile wavfile1;
volatile Wavfile wavfile2;
volatile Wavfile wavfile3;

volatile Wavfile wavmono[2];

void wavdisplay_on_oledbw(const Wavfile *wavfile);

int main()
{
  if(EXCLUSIVE_ID==0)
  {
    int file_samples;
    int interval;
    short *wavdata;

    wavread(&wavfile, "f19d1738_nohash_0_happy.wav");
    print_wav(&wavfile);
    wavwrite(&wavfile, "test.wav");

    wavdisplay_on_oledbw(&wavfile);

#if 1 // wavmake
    file_samples = wavfile.data_chunk_size / (wavfile.bit_per_sample / 8);
    user_wavfile = wavmake(wavfile.sample_freq, wavfile.channel_num, 
                    wavfile.bit_per_sample, file_samples, wavfile.data);
    print_wav(user_wavfile);
    wavwrite(user_wavfile, "test-1.wav");
#endif

#if 1
    wavread(&wavfile1, "M1F1_int16_AFsp.wav");
    print_wav(&wavfile1);
    wavread(&wavfile2, "M1F1_int24_AFsp.wav");
    print_wav(&wavfile2);
    wavread(&wavfile3, "M1F1_int32_AFsp.wav");
    print_wav(&wavfile3);
#endif

#if 1 // wavsplit
    printf("~~~~~~~~~~~~~~~ wavsplit ~~~~~~~~~~~~\n");
    wavsplit(wavmono, &wavfile2);
    print_wav(&wavmono[0]);
    wavwrite(&wavmono[0], "test0.wav");
    print_wav(&wavmono[1]);
    wavwrite(&wavmono[1], "test1.wav");
#endif
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
