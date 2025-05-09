# 1 "/tmp/comgr-4169b3/input/CompileSource"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 390 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "/tmp/comgr-4169b3/input/CompileSource" 2
#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable

typedef uint uint32;
typedef ulong uint64;
typedef struct { uint64 s0; uint32 s1; } uint96;


__attribute__((noinline))
uint96 uint96_add_64(const uint96 x, const uint64 y) {
    uint96 r;
    const uint64 s0 = x.s0 + y;
    r.s0 = s0;
    r.s1 = x.s1 + ((s0 < y));
    return r;
}

int uint96_equal(uint96 a, uint96 b) {
    return (a.s0 == b.s0) && (a.s1 == b.s1);
}

__kernel void test_uint96_add_64(__global char* results) {
    int idx = get_global_id(0);
    int passed = 1;

    {
        uint96 x = {1, 2};
        uint64 y = 3;
        uint96 expected = {4, 2};
        uint96 result = uint96_add_64(x, y);
        if (!uint96_equal(result, expected)) {
            printf("test 1 failed\n");
            passed = 0;
        }
    }

    {
        uint96 x = {0x123456789ABCDEF0UL, 0x12345678};
        uint64 y = 0x1111111111111111UL;
        uint96 expected = {2541551405711093761, 0x12345678};

        uint96 result = uint96_add_64(x, y);
        if (!uint96_equal(result, expected)) {
            printf("test 2 failed\n");
            passed = 0;
        }
    }

    {
        uint96 x = {0xFFFFFFFFFFFFFFFFUL, 0x12345678};
        uint64 y = 1;
        uint96 expected = {0x0UL, 0x12345679};
        uint96 result = uint96_add_64(x, y);
        if (!uint96_equal(result, expected)) {
            printf("test 3 failed\n");
            passed = 0;
        }
    }

    {
        uint96 x = {0xFFFFFFFFFFFFFFFEUL, 0x12345678};
        uint64 y = 3;
        uint96 expected = {0x1UL, 0x12345679};
        uint96 result = uint96_add_64(x, y);
        if (!uint96_equal(result, expected)) {
            printf("test 4 failed\n");
            passed = 0;
        }
    }

    {
        uint96 x = {0x123456789ABCDEF0UL, 0x12345678};
        uint64 y = 0;
        uint96 expected = x;
        uint96 result = uint96_add_64(x, y);
        if (!uint96_equal(result, expected)) {
            printf("test 5 failed\n");
            passed = 0;
        }
    }

    {
        uint96 x = {0xFFFFFFFFFFFFFFFFUL, 0xFFFFFFFF};
        uint64 y = 0xFFFFFFFFFFFFFFFFUL;
        uint96 expected = {0xFFFFFFFFFFFFFFFEUL, 0};
        uint96 result = uint96_add_64(x, y);
        if (!uint96_equal(result, expected)) {
            printf("test 6 failed\n");
            passed = 0;
        }
    }

    {
        uint96 x = {0xFFFFFFFFFFFFFFFFUL, 0xFFFFFFFE};
        uint64 y = 1;
        uint96 expected = {0x0UL, 0xFFFFFFFF};
        uint96 result = uint96_add_64(x, y);
        if (!uint96_equal(result, expected)) {
            printf("test 7 failed\n");
            passed = 0;
        }
    }

    results[idx] = passed;
}
