#ifndef _CLK_DEV_H_
#define _CLK_DEV_H_

#include "common.h"
#include "clk_reg.h"

typedef enum {
	CLK_FREQ_M4_72M = 0,
	CLK_FREQ_M4_36M
}clk_freq_m4_t;

void clk_set_m4_freq(clk_freq_m4_t clk_m4);

#endif
