#include <stdint.h>
#include <stddef.h>
#include "ervp_variable_allocation.h"
#include "ervp_malloc.h"
#include "kws_name_list_file.h"
#ifndef GENERATE_HEX_USING_GCC
#include "platform_info.h"
#endif

const uint8_t kws_name_list_file_raw[] ALIGNED_DATA BIG_DATA = {
0x5f,0x73,0x69,0x6c,0x65,0x6e,0x63,0x65,0x5f,0xa,0x5f,0x75,0x6e,0x6b,0x6e,0x6f,0x77,0x6e,0x5f,0xa,0x68,0x61,0x70,0x70,0x79,0xa,0x77,0x6f,0x77,0xa
};

static char kws_name_list_file_filename[] = "kws_name_list";
static fakefile_chunk_t kws_name_list_file_fakefile_chunk;
static FAKEFILE kws_name_list_file;

#ifdef USE_FAKEFILE
static void __attribute__ ((constructor)) construct_kws_name_list_file()
{
	fakefile_chunk_init_(&kws_name_list_file_fakefile_chunk);
	kws_name_list_file_fakefile_chunk.data = (uint8_t*)kws_name_list_file_raw;
	kws_name_list_file_fakefile_chunk.size = sizeof(kws_name_list_file_raw);
	kws_name_list_file_fakefile_chunk.current_size = sizeof(kws_name_list_file_raw);
	fakefile_init_(&kws_name_list_file);
	kws_name_list_file.status = FILE_STATUS_READ_ONLY;
	kws_name_list_file.name = kws_name_list_file_filename;
	kws_name_list_file.head = &kws_name_list_file_fakefile_chunk;
	fakefile_dict_add(&kws_name_list_file);
};
static void __attribute__ ((destructor)) destruct_kws_name_list_file()
{
};
#endif