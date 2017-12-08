# cuda-intro

```
$ time ./dist_v1/main.exe 

real	0m0.002s
user	0m0.000s
sys	0m0.002s

$ time ./dist_v1_cuda/main.exe 

real	0m0.453s
user	0m0.023s
sys	0m0.424s

$ time ./dist_v2_cuda/main.exe 

real	0m0.380s
user	0m0.019s
sys	0m0.356s


$ time ./dist_v2_cuda_unified/main.exe

real	0m0.580s
user	0m0.016s
sys	0m0.509s
```
