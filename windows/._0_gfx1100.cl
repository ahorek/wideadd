/* Compiler options:
-c -emit-llvm -target amdgcn-amd-amdhsa -x cl -O3 -cl-kernel-arg-info -D__OPENCL_VERSION__=200 -D__IMAGE_SUPPORT__=1 -Xclang -cl-ext=+cl_khr_fp64,+cl_khr_global_int32_base_atomics,+cl_khr_global_int32_extended_atomics,+cl_khr_local_int32_base_atomics,+cl_khr_local_int32_extended_atomics,+cl_khr_int64_base_atomics,+cl_khr_int64_extended_atomics,+cl_khr_3d_image_writes,+cl_khr_byte_addressable_store,+cl_khr_fp16,+cl_khr_gl_sharing,+cl_amd_device_attribute_query,+cl_amd_media_ops,+cl_amd_media_ops2,+cl_khr_d3d10_sharing,+cl_khr_d3d11_sharing,+cl_khr_dx9_media_sharing,+cl_khr_image2d_from_buffer,+cl_khr_subgroups,+cl_khr_gl_event,+cl_khr_mipmap_image,+cl_khr_mipmap_image_writes,+cl_amd_copy_buffer_p2p,+cl_amd_planar_yuv -mllvm -amdgpu-prelink -mcode-object-version=5  -include opencl-c.h 
Hash to override:
  Source: 0xae1d467be8e6da37
  Source + clang options: 0x2b90464db7e89826
*/

#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable

typedef uint    uint32;
typedef ulong   uint64;
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
