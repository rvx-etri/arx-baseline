#include "platform_info.h"
#include "ervp_printf.h"
#include "ervp_multicore_synch.h"
#include "ervp_variable_allocation.h"
#include "ervp_malloc.h"
#include "ervp_core_id.h"
#include "ervp_delay.h"
#include "ervp_mcom_input.h"

#include "frvp_spi.h"
#include "ervp_timer.h"
#include "ervp_interrupt.h"
#include "ervp_profiling.h"

#include "darknet.h"
#include "classifier.h"

#define NSAMPLES        (16000)

#define SPI_FREQ            1000000
#define SPI_MODE            SPI_SCKMODE_0
#define PORT_ID             SPI_INDEX_FOR_READYMADE
#define NUM_BYTES         2

static const SpiConfig spiconfig = {SPI_DIVSOR(SPI_FREQ), SPI_MODE, (1<<PORT_ID), SPI_CSMODE_OFF, (SPI_FMT_PROTO(SPI_PROTO_S) | SPI_FMT_ENDIAN(SPI_ENDIAN_MSB) | SPI_FMT_LEN(8)), 1};

void mic3_config_spi()
{
  spi_configure(&spiconfig);
}

unsigned short read_mic3_value()
{
  unsigned short result;
  unsigned char value[NUM_BYTES];
  unsigned char *p_result = (unsigned char *)&result;

  spi_start();
  spi_read(NUM_BYTES, value);
  spi_end();

  *(p_result + 1) = value[0];
  *(p_result) = value[1];

  return result;
}

volatile int sample_count = 0;

int *data_12bits;

void int_service_routine()
{
  unsigned short data = read_mic3_value();

  if(sample_count < NSAMPLES)
  {
    data_12bits[sample_count] = data; 
    sample_count++;
  }
  if(sample_count >= NSAMPLES)
  {
    stop_timer();
  }
}

int main(int argc, char **argv)
{
  if(EXCLUSIVE_ID==0)
  {
    int max = 0;
    int min = 0;
    float fmax = 0;
    float fmin = 0;
    int key;
    float *fdata;
    data_12bits = (int *)malloc(sizeof(int)*NSAMPLES);
    fdata = (float *)malloc(sizeof(float)*NSAMPLES);

    OledInit();
    init_network("kws_name_list", "kws_lms.cfg", "kws_lms.weights");

    config_timer_interval_us(63);
    register_isr_timer(int_service_routine);
    allow_interrupt_timer();
    enable_interrupt();

    printf("\npress the space bar for recording and kws \n");
    while(1)
    {
      key = getc_from_mcom();
      printf("key: [%c]\n", key);
      if(key==' ')
      {
        // init recording
        sample_count = 0;
        mic3_config_spi();
        start_timer_periodic();

        while(sample_count < NSAMPLES);

        for(int k=0; k < NSAMPLES; k++)
        {
          fdata[k] = (float)(data_12bits[k] - 2048)/2048;
        }

#if 1 // draw nomalized wave
        fmin = 0;
        fmax = 0;
        for(int k=0; k < NSAMPLES; k++)
        {
          if(fdata[k] > fmax) fmax = fdata[k];
          if(fdata[k] < fmin) fmin = fdata[k];
        }
        // wave file max[24717] min[-32768]
        printf("fdata max[%f] min[%f]\n", fmax, fmin);

        if(fmax < -fmin)      
          fmax = -fmin;
#endif

        int interval = NSAMPLES / 128;
        for(int i=0; i < 127; i++)
        {
#if 0 // draw raw wave 
          OledMoveTo(i, data_12bits[i*interval]>>7);
          OledLineTo(i+1, data_12bits[(i+1)*interval]>>7);
#else // draw nomalized wave
          OledMoveTo(i, (int)((fdata[i*interval]/fmax + 1)*15));
          OledLineTo(i+1, (int)((fdata[(i+1)*interval]/fmax + 1)*15 ));
#endif
        }
        oled_bw_config_spi();
        OledUpdate();
        OledClearBuffer();

        predict_wav(fdata);
        printf("\npress the space bar for recording and kws\n");
      }
      else if(key=='x')
      {
        break;
      }
    }
    free(fdata);
    free(data_12bits);
  }

  return 0;
}
