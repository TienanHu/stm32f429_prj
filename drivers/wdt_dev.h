#ifndef INCLUDES_DRV_INC_DRV_WDT_H_
#define INCLUDES_DRV_INC_DRV_WDT_H_

#include "common.h"
#include "wdt_reg.h"

void wdt_enable(uint32_t cycle);
void wdt_feed(void);

#endif /* INCLUDES_DRV_INC_DRV_WDT_H_ */
