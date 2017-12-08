#include <stdio.h>

#define N 64
#define TPB 32 // thread per block

__device__ float scale(int i, int n){
  return static_cast<float>(i)/(n-1);
}

// Compute the distance between 2 points in a line
__device__ float distance(float x1, float x2){
  return sqrt((x2-x1)*(x2-x1));
}

__global__ void distanceKernel(float *d_out, float ref, int len){
  const int i= blockIdx.x*blockDim.x + threadIdx.x;
  const float x = scale(i, len);
  d_out[i] = distance(x, ref);
  // printf("i=%2d: dist from %f to %f is %f.\n", i, ref, x, d_out[i]);
}

int main(){
  float *d_out = 0;

  const float ref = 0.5f;

  cudaMalloc(&d_out, N*sizeof(float));

  // block num: N/TPB
  distanceKernel<<<N/TPB, TPB>>>(d_out, ref,  N);

  cudaFree(d_out);
  return 0;
}