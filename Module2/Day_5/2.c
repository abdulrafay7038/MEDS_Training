#include <stdio.h>
#include <stdint.h>

// Support both RV32 and RV64 with compile-time switch
#ifdef RV64
typedef uint64_t reg_t;
#define REG_FMT "0x%016lX"
#else
typedef uint32_t reg_t;
#define REG_FMT "0x%08X"
#endif

// Debug logging macro (compiled out in release builds)
#ifdef DEBUG
#define LOG(fmt, ...) \
    fprintf(stderr, "[%s:%d] " fmt "\n", \
            __FILE__, __LINE__, ##__VA_ARGS__)
#else
#define LOG(fmt, ...)
#endif

int main(void) {
    reg_t pc = 0x1000;
    reg_t instruction = 0x12345678;

    LOG("Program started");
    LOG("PC = " REG_FMT, pc);
    LOG("Instruction = " REG_FMT, instruction);

    printf("PC = " REG_FMT "\n", pc);
    printf("Instruction = " REG_FMT "\n", instruction);

    return 0;
}