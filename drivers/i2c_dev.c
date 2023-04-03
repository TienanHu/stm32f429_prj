#include "i2c_dev.h"

void i2c_init(void)
{
	HW_WR32(I2C_TX_REG, 0x01);
	HW_FIELD(I2C_TX_REG, 0xffffffff, (uint32_t)0x3 << 4);
}
