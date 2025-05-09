#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define WORK_ITEMS 1024

char* read_kernel_source(const char* filename, size_t* size) {
    FILE* file = fopen(filename, "rb");
    if (!file) {
        fprintf(stderr, "Failed to open %s\n", filename);
        return NULL;
    }

    fseek(file, 0, SEEK_END);
    *size = ftell(file);
    rewind(file);

    char* source = (char*)malloc(*size + 1);
    if (!source) {
        fprintf(stderr, "Failed to allocate memory for kernel source\n");
        fclose(file);
        return NULL;
    }

    fread(source, 1, *size, file);
    source[*size] = '\0';

    fclose(file);
    return source;
}

int main() {
    cl_int err;
    cl_platform_id platform;
    cl_device_id device;
    cl_context context;
    cl_command_queue queue;
    cl_program program;
    cl_kernel kernel;
    
    err = clGetPlatformIDs(1, &platform, NULL);
    err = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 1, &device, NULL);
    context = clCreateContext(NULL, 1, &device, NULL, NULL, &err);
    cl_command_queue_properties props = {};
    queue = clCreateCommandQueueWithProperties(context, device, &props, &err);
    
    const char* kernel_filename = "testadd.cl";
    size_t source_size;
    char* kernel_source = read_kernel_source(kernel_filename, &source_size);
    if (!kernel_source) {
        return -1;
    }
    
    program = clCreateProgramWithSource(context, 1, (const char**)&kernel_source, 
                                       &source_size, &err);
    if (err != CL_SUCCESS) {
        fprintf(stderr, "Failed to create program from source\n");
        free(kernel_source);
        return -1;
    }
    
    char pgmOptions[1024];
	strcpy(pgmOptions, " -save-temps=.");
    err = clBuildProgram(program, 1, &device, pgmOptions, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Failed to build program\n");
        size_t logSize;
        clGetProgramBuildInfo(program, device, CL_PROGRAM_BUILD_LOG, 0, NULL, &logSize);
        char* log = (char*)malloc(logSize);
        clGetProgramBuildInfo(program, device, CL_PROGRAM_BUILD_LOG, logSize, log, NULL);
        printf("Build log:\n%s\n", log);
        free(log);
        clReleaseProgram(program);
        clReleaseCommandQueue(queue);
        clReleaseContext(context);
        return 1;
    }
    free(kernel_source);
    
    kernel = clCreateKernel(program, "test_uint96_add_64", &err);
    if (!kernel) {
        printf("Failed to create kernel\n");
        clReleaseProgram(program);
        clReleaseCommandQueue(queue);
        clReleaseContext(context);
        return 1;
    }
    
    const size_t workSize = 16;
    char* hostResults = (char*)malloc(workSize * sizeof(char));
    
    cl_mem resultsBuffer;
    resultsBuffer = clCreateBuffer(context, CL_MEM_WRITE_ONLY, 
                                 workSize * sizeof(char), NULL, &err);
    if (!resultsBuffer) {
        printf("Failed to create buffer\n");
        clReleaseKernel(kernel);
        clReleaseProgram(program);
        clReleaseCommandQueue(queue);
        clReleaseContext(context);
        free(hostResults);
        return 1;
    }
    
    err = clSetKernelArg(kernel, 0, sizeof(cl_mem), &resultsBuffer);
    if (err != CL_SUCCESS) {
        printf("Failed to set kernel argument\n");
        clReleaseMemObject(resultsBuffer);
        clReleaseKernel(kernel);
        clReleaseProgram(program);
        clReleaseCommandQueue(queue);
        clReleaseContext(context);
        free(hostResults);
        return 1;
    }
    
    size_t globalWorkSize = workSize;
    err = clEnqueueNDRangeKernel(queue, kernel, 1, NULL, 
                                &globalWorkSize, NULL, 0, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Failed to execute kernel\n");
        clReleaseMemObject(resultsBuffer);
        clReleaseKernel(kernel);
        clReleaseProgram(program);
        clReleaseCommandQueue(queue);
        clReleaseContext(context);
        free(hostResults);
        return 1;
    }
    
    err = clEnqueueReadBuffer(queue, resultsBuffer, CL_TRUE, 0,
                             workSize * sizeof(char), hostResults, 
                             0, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Failed to read results\n");
        clReleaseMemObject(resultsBuffer);
        clReleaseKernel(kernel);
        clReleaseProgram(program);
        clReleaseCommandQueue(queue);
        clReleaseContext(context);
        free(hostResults);
        return 1;
    }
    
    int allPassed = 1;
    for (size_t i = 0; i < workSize; i++) {
        if (!hostResults[i]) {
            printf("Test failed in work item %zu\n", i);
            allPassed = 0;
        }
    }
    
    if (allPassed) {
        printf("All tests passed across %zu work items!\n", workSize);
    } else {
        printf("Some tests failed\n");
    }
    
    clReleaseMemObject(resultsBuffer);
    clReleaseKernel(kernel);
    clReleaseProgram(program);
    clReleaseCommandQueue(queue);
    clReleaseContext(context);
    free(hostResults);
    
    return allPassed ? 0 : 1;
}