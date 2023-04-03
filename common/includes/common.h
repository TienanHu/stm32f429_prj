#ifndef __COMMOM_H
#define __COMMOM_H

#include <stdint.h>
#include <string.h>
#include "ARMCM4_FP.h"

#define		HW_WR8(reg_addr, val)			(*(volatile uint8_t*)(reg_addr) = (val))
#define		HW_RD8(reg_addr)				(*(volatile uint8_t*)(reg_addr))

#define		HW_WR16(reg_addr, val)			(*(volatile uint16_t*)(reg_addr) = (val))
#define		HW_RD16(reg_addr)				(*(volatile uint16_t*)(reg_addr))

#define		HW_WR32(reg_addr, val)			(*(volatile uint32_t*)(reg_addr) = (val))
#define		HW_RD32(reg_addr)				(*(volatile uint32_t*)(reg_addr))

#define		HW_FIELD(reg_addr, mask, val)	(HW_WR32(reg_addr, (HW_RD32(reg_addr) & (~(mask))) | (val)))
#endif
