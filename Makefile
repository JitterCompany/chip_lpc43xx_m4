
TOOLCHAIN_PREFIX=arm-none-eabi-
CC=$(TOOLCHAIN_PREFIX)gcc
AR=$(TOOLCHAIN_PREFIX)ar
LD=$(TOOLCHAIN_PREFIX)ld
SZ=$(TOOLCHAIN_PREFIX)size
RM := rm -rf

LIBRARY_NAME = lpc_chip_43xx_m4
SRC_DIR = ./src/
BUILD_DIR = ./build/
ILIBS = -I./inc

CORE = m4
GLOBAL_DEFS = -D__LPC43XX__ -DCORE_M4 
CFLAGS = -O0 -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -std=gnu99 -mcpu=cortex-$(CORE) -mthumb -MMD -MP

OBJS := \
adc_18xx_43xx.o \
aes_18xx_43xx.o \
atimer_18xx_43xx.o \
ccan_18xx_43xx.o  \
chip_18xx_43xx.o \
dac_18xx_43xx.o \
eeprom_18xx_43xx.o \
emc_18xx_43xx.o \
enet_18xx_43xx.o \
evrt_18xx_43xx.o \
fpu_init.o \
gpdma_18xx_43xx.o \
gpio_18xx_43xx.o \
gpiogroup_18xx_43xx.o \
hsadc_18xx_43xx.o \
i2c_18xx_43xx.o \
i2cm_18xx_43xx.o \
i2s_18xx_43xx.o \
lcd_18xx_43xx.o \
otp_18xx_43xx.o \
pinint_18xx_43xx.o \
pmc_18xx_43xx.o \
rgu_18xx_43xx.o \
ring_buffer.o \
ritimer_18xx_43xx.o \
rtc_18xx_43xx.o \
sct_18xx_43xx.o \
scu_18xx_43xx.o \
sdif_18xx_43xx.o \
sdmmc_18xx_43xx.o \
spi_18xx_43xx.o \
ssp_18xx_43xx.o \
sysinit_18xx_43xx.o \
timer_18xx_43xx.o \
uart_18xx_43xx.o \
wwdt_18xx_43xx.o \
clock_18xx_43xx.o


OBJS_F = $(addprefix $(BUILD_DIR), $(OBJS))
LIBRARY_FILE = "./lib$(LIBRARY_NAME).a"


all: post-build


.SECONDEXPANSION:
$(LIBRARY_FILE) : $$(OBJS_F)
	@mkdir -p "$(BUILD_DIR)"
	@echo 'Building target: $@'
	@echo 'Invoking: MCU Archiver'
	 
	$(AR) -r  $@ $(OBJS_F) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '
	#$(MAKE) --no-print-directory post-build

# Other Targets
clean:
	-$(RM) $(BUILD_DIR)
	-$(RM) $(LIBRARY_FILE)
	-@echo ' '


post-build: $(LIBRARY_FILE)
	-@echo 'Performing post-build steps'
	$(SZ) $(LIBRARY_FILE)
	-@echo ' '
	-@echo ' '
	-@echo ' '

$(BUILD_DIR)%.o: $(SRC_DIR)%.c
	mkdir -p '$(dir $@)'
	@echo 'Building file: $@ in $(BUILD_DIR) from $<'
	@echo 'Invoking: MCU C Compiler'
	@echo flags=$(CFLAGS)
	$(CC) $(GLOBAL_DEFS) $(ILIBS) $(CFLAGS) -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

.PHONY: all post-build clean dependents
.SECONDARY:

