#ifndef SDMMC_CLOCK_DIVIDE_H
#define SDMMC_CLOCK_DIVIDE_H

/**
 * Calculate the clock divider value to match a givien base clock frequency
 * with a maximun sdcard speed.
 * The result should be written to the SDMMC CLKDIV register.
 *
 * Note: the result is not the divider itself, as the CLKDIV register applies
 * an extra factor of 2.
 */
static inline uint32_t sdmmc_clock_divide_calc(uint32_t base_clock_rate,
        uint32_t sdcard_speed) {
    
    // clock is not faster than maximum: no division required
    if(base_clock_rate <= sdcard_speed) {
        return 0;
    }

    // the value we calculate should be a factor 2 too low, because the
    // SDMMC hardware divider divides by 2*div
    sdcard_speed*= 2;

    // calculate the minimum required div value by rounding up the division
    return (base_clock_rate + sdcard_speed - 1)/sdcard_speed; 
}

#endif

