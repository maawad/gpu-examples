#include <thrust/device_vector.h>
#include <iostream>

template<typename T>
__global__ void vector_add(const T* a, const T* b, T* c, size_t size) {
    const auto thread_idx = blockIdx.x * blockDim.x + threadIdx.x; 
    const auto stride = gridDim.x * blockDim.x;                 

    for ( auto idx = thread_idx; idx < size; idx += stride) {
        c[idx] = a[idx] + b[idx];
    }
}

int main() {
    size_t N = 1 << 20; 
    thrust::device_vector<float> d_a(N, 1.0f);
    thrust::device_vector<float> d_b(N, 2.0f);
    thrust::device_vector<float> d_c(N);

    std::cout << "Mem Set\n";


    size_t threads_per_block = 256;
    size_t blocks_per_grid = (N + threads_per_block - 1) / threads_per_block;
    blocks_per_grid = std::min((size_t)65535, blocks_per_grid); 
    vector_add<<<blocks_per_grid, threads_per_block>>>(d_a.data().get(), d_b.data().get(), d_c.data().get(), N);

    const auto status = hipDeviceSynchronize();
    if(status != hipSuccess){
        std::cout << "Kernel launch failed!" << std::endl;
        return -1;
    }

    for (size_t i = 0; i < N; ++i) {
        if (d_c[i] != 3.0f) {
            std::cerr << "Mismatch at index " << i << ": " << d_c[i] << std::endl;
            return -1;
        }
    }

    std::cout << "Vector addition successful!" << std::endl;

    return 0;
}
