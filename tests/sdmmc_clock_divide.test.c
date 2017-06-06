#include <stdbool.h>
#include <string.h>

#include "unity.h"
#include "sdmmc_clock_divide.h"

void test_sdmmc_clock_divide__divides__correctly(void)
{
    TEST_ASSERT_EQUAL(0, sdmmc_clock_divide_calc(12000000,      25000000));
    TEST_ASSERT_EQUAL(0, sdmmc_clock_divide_calc(25000000,      25000000));
    TEST_ASSERT_EQUAL(1, sdmmc_clock_divide_calc(25000000+1,    25000000));
    TEST_ASSERT_EQUAL(1, sdmmc_clock_divide_calc(50000000-1,    25000000));
    TEST_ASSERT_EQUAL(1, sdmmc_clock_divide_calc(50000000,      25000000));
    TEST_ASSERT_EQUAL(2, sdmmc_clock_divide_calc(50000000+1,    25000000));
    TEST_ASSERT_EQUAL(2, sdmmc_clock_divide_calc(75000000,      25000000));
    TEST_ASSERT_EQUAL(2, sdmmc_clock_divide_calc(100000000,     25000000));
    TEST_ASSERT_EQUAL(3, sdmmc_clock_divide_calc(100000000+1,   25000000));
}


int main(void)
{
    UNITY_BEGIN();

    RUN_TEST(test_sdmmc_clock_divide__divides__correctly);

    UNITY_END();

    return 0;
}
