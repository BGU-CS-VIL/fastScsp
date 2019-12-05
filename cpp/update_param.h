#include "cuda.h"
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#ifndef MY_SP_STRUCT
#define MY_SP_STRUCT
#include "my_sp_struct.h"
#endif

__global__ void clear_fields(superpixel_params* sp_params, superpixel_GPU_helper* sp_gpu_helper, const int nsuperpixel);

__global__ void sum_by_label(const double* image_gpu_double, const int* seg_gpu, superpixel_params* sp_params, superpixel_GPU_helper* sp_gpu_helper, const int nPixels, const int xdim);

__global__ void calculate_mu_and_sigma(superpixel_params* sp_params, superpixel_GPU_helper* sp_gpu_helper, const int nsuperpixel, const int prior_sigma_s, const int prior_count);

__host__ void update_param(const double* image_gpu_double,const int* seg_gpu, superpixel_params* sp_params, superpixel_GPU_helper* sp_gpu_helper, const int nPixels, const int nSps, const int xdim, const int ydim,  const int prior_sigma_s, const int prior_count);