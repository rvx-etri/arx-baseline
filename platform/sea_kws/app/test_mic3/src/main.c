#include "platform_info.h"
#include "ervp_printf.h"
#include "ervp_multicore_synch.h"
#include "ervp_delay.h"

#include "frvp_spi.h"

#include "PmodOLED.h"
#include "OledChar.h"
#include "OledGrph.h"

#define SPI_FREQ            1000000
#define SPI_MODE            SPI_SCKMODE_0

#define PORT_ID             SPI_INDEX_FOR_READYMADE
#define NUM_BYTES     		2


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

int get_mic3_value_for_oled_bw()
{
  unsigned short result;
  unsigned char value[NUM_BYTES];
  unsigned char *p_result = (unsigned char *)&result;

  spi_start();
  spi_read(NUM_BYTES, value);
  spi_end();

  *(p_result + 1) = value[0];
  *(p_result) = value[1];

  return (int)(result>>7);
}

int cnt_sample = 0;

void int_service_routine()
{
  printf("Sample count: %d\n", cnt_sample);
}

int main() {
  printf("mic3!\n");
  config_timer_interval_ms(1000);
  register_isr_timer(int_service_routine);
  start_timer_periodic();
  allow_interrupt_timer();
  enable_interrupt();

  int col_pointer = 0;
  int priv_row;
  int curr_row;
  OledInit();
  //OledSetDrawColor(1); // default
  //OledSetDrawMode(modOledSet);	// default

  while(1)
  {
    //printf("%d\n", read_mic3_value());
    mic3_config_spi();
    curr_row = get_mic3_value_for_oled_bw();

    if(col_pointer > 0)
    {
      OledMoveTo(col_pointer-1, priv_row);
      OledLineTo(col_pointer, curr_row);
    }
    if(col_pointer == ccolOledMax)
    {
      oled_bw_config_spi();
      OledUpdate();
      OledClearBuffer();
    }

    col_pointer++;
    if(col_pointer > ccolOledMax)
      col_pointer = 0;
    priv_row = curr_row;
    cnt_sample++;
    //delay_ms(2);
  }

  return 0;
}
