ifeq ($(OS),Windows_NT)
RM_FILE = cmd /c del /q
RM_DIR = cmd /c rmdir /s /q
FS = \\
MK_DIR = mkdir
else
RM_FILE = /bin/rm -rf
RM_DIR = /bin/rm -rf
FS = /
MK_DIR = mkdir -p
endif


CROSS_COMPILE   := arm-none-eabi-

CC = 		$(CROSS_COMPILE)gcc
LD = 		$(CROSS_COMPILE)gcc
OBJCOPY = 	$(CROSS_COMPILE)objcopy
OBJDUMP = 	$(CROSS_COMPILE)objdump


TESTNAME = stm32f469
ELF_FILE = $(TESTNAME).elf

START_SRCS  = ./startup
DRV_SRCS    = ./drivers
TEST_SRCS   = ./tests
COM_SRCS    = ./common
CMSIS_SRCS	= ./CMSIS
CUR_DIR = ./
OUT_DIR = output
OBJ_DIR = $(OUT_DIR)/obj

CFLAGS += -mcpu=cortex-m4 -mthumb -DARMCM4_FP -g -O0 -fdata-sections -ffunction-sections -fno-builtin $(INCLUDES)
LFLAGS = -T $(START_SRCS)/$(TESTNAME).lds --specs=nosys.specs


INCLUDES =	-I$(START_SRCS)\
			-I$(CMSIS_SRCS)\
			-I$(DRV_SRCS)\
			-I$(DRV_SRCS)/reg_inc\
			-I$(COM_SRCS)/includes\
			-I$(TEST_SRCS)

DRV_OBJS = \
			$(OBJ_DIR)/uart_dev.o \
			$(OBJ_DIR)/clk_dev.o \
			$(OBJ_DIR)/i2c_dev.o \

TEST_OBJS = \
			$(OBJ_DIR)/i2c_test.o \

COM_OBJS = \
			$(OBJ_DIR)/delay.o \
			$(OBJ_DIR)/retarget.o \

DEP_FILES = $(OBJ_FILES:%=%.d)

OBJ_FILES =	\
			$(DRV_OBJS)\
			$(TEST_OBJS)\
			$(COM_OBJS)\
			$(OBJ_DIR)/startup_stm32f469.o\
			$(OBJ_DIR)/system_ARMCM4.o\
			$(OBJ_DIR)/interrupt.o\
			$(OBJ_DIR)/main.o

.phony: all

all:$(ELF_FILE)
$(ELF_FILE): $(OBJ_DIR) $(OBJ_FILES)
	@ echo "  LD   Linking  $(TESTNAME).elf"
	@ $(LD) $(LFLAGS) -o $(OUT_DIR)/$(TESTNAME).elf   $(OBJ_FILES)
	@ echo "  OBJCOPY Objcopying  $(TESTNAME).bin"
	@ $(OBJCOPY) -O binary -S $(OUT_DIR)/$(TESTNAME).elf $(OUT_DIR)/$(TESTNAME).bin
	@ echo "  OBJDUMP Objdumping  $(TESTNAME).dis"
	@ $(OBJDUMP) -D $(OUT_DIR)/$(TESTNAME).elf > $(OUT_DIR)/$(TESTNAME).dis
	debugedit -b "/home/tnhu/work" -d "Z:/" $(OUT_DIR)/$(TESTNAME).elf

clean:
	- $(RM_DIR) $(OUT_DIR)

$(OBJ_DIR):
	$(MK_DIR) $(subst /,$(FS),$@)

$(OBJ_DIR)/%.o : $(START_SRCS)/%.c
	@ echo "  CC   $@"
	@ $(CC) -o $@ $< -c -MD -MF $@.d $(CFLAGS)


$(OBJ_DIR)/%.o : $(DRV_SRCS)/%.c
	@ echo "  CC   $@"
	@ $(CC) -o $@ $< -c -MD -MF $@.d $(CFLAGS)

$(OBJ_DIR)/%.o : $(TEST_SRCS)/%.c
	@ echo "  CC   $@"
	@ $(CC) -o $@ $< -c -MD -MF $@.d $(CFLAGS)

$(OBJ_DIR)/%.o : $(COM_SRCS)/%.c	
	@ echo "  CC   $@"
	@ $(CC) -o $@ $< -c -MD -MF $@.d $(CFLAGS)

$(OBJ_DIR)/%.o : $(CMSIS_SRCS)/%.c
	@ echo "  CC   $@"
	@ $(CC) -o $@ $< -c -MD -MF $@.d $(CFLAGS)

-include $(DEP_FILES)
