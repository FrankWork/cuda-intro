#include <stdio.h>

#define N 64
#define TPB 32 // thread per block

float scale(int i, int n){
  return static_cast<float>(i)/(n-1);
}

// Compute the distance between 2 points in a line
__device__ 
float distance(float x1, float x2){
  return sqrt((x2-x1)*(x2-x1));
}

__global__ 
void distanceKernel(float *d_out, float *d_in, float ref){
  const int i= blockIdx.x*blockDim.x + threadIdx.x;
  const float x = d_in[i];
  d_out[i] = distance(x, ref);
  // printf("i=%2d: dist from %f to %f is %f.\n", i, ref, x, d_out[i]);
}

int main(){
  float *in = 0;
  float *out = 0;

  const float ref = 0.5f;

  cudaMallocManaged(&in, N*sizeof(float));
  cudaMallocManaged(&out, N*sizeof(float));

  for(int i=0;i<N;++i){
    in[i] = scale(i,N);
  }

  // block num: N/TPB
  distanceKernel<<<N/TPB, TPB>>>(out, in, ref);
  cudaDeviceSynchronize();

  cudaFree(in);
  cudaFree(out);
  return 0;
}