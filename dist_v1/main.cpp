#include <math.h>

#define N 64

float scale(int i, int n){
  return static_cast<float>(i)/(n-1);
}

// Compute the distance between 2 points in a line
float distance(float x1, float x2){
  return sqrt((x2-x1)*(x2-x1));
}

int main(){
  float out[N] = {0.0f};

  float ref = 0.5f;

  for(int i=0;i<N;++i){
    float x = scale(i, N);
    out[i] = distance(x, ref);
  }

  return 0;
}