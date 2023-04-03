#include "common.h"
#include "i2c_test.h"
#include "clk_dev.h"
#include "stdio.h"

void sys_init(clk_freq_m4_t clk);

uint32_t g_val;

int main(void)
{
	clk_freq_m4_t clk = CLK_FREQ_M4_72M;
	uint32_t val;
	printf("stm32 start...\r\n");

	g_val = 1;
	val   = 2;

	sys_init(clk);
	i2c_test();

	// void (*ddr_code)(void);
	// ddr_code = (void (*)(void))0x10000000;
	// ddr_code();

	while(1) {
		__NOP();
	}
}

void sys_init(clk_freq_m4_t clk)
{
	clk_set_m4_freq(clk);
}
