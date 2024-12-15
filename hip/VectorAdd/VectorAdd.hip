#include <hip/hip_runtime.h>
#include <iostream>
#include <vector>
#include <memory> 

#define gpu_check(call)                                               \
    do {                                                              \
        hipError_t err = (call);                                      \
        if (err != hipSuccess) {                                      \
            std::cerr << "HIP Error: " << hipGetErrorString(err)      \
                      << " at " << __FILE__ << ":" << __LINE__ << std::endl; \
            std::exit(EXIT_FAILURE);                                  \
        }                                                             \
    } while (0)

class gpu_allocator {
public:
    template <typename T>
    static T* allocate(size_t size) {
        T* ptr = nullptr;
        gpu_check(hipMalloc(&ptr, size * sizeof(T)));
        return ptr;
    }

    template <typename T>
    static void deallocate(T* ptr) {
        if (ptr) {
            gpu_check(hipFree(ptr));
        }
    }
};

template <typename T>
struct GPUDeleter {
    void operator()(T* ptr) const {
        gpu_allocator::deallocate(ptr);
    }
};

template <typename T>
using gpu_unique_ptr = std::unique_ptr<T, GPUDeleter<T>>;

template <typename T>
__global__ void vector_add(const T* a, const T* b, T* c, size_t size) {
    const auto thread_idx = blockIdx.x * blockDim.x + threadIdx.x; 
    const auto stride = gridDim.x * blockDim.x;                  

    for (auto idx = thread_idx; idx < size; idx += stride) {
        c[idx] = a[idx] + b[idx];
        printf("Adding %f to %f\n", a[idx], b[idx]);
    }
}

int main() {
    size_t N = 1 << 20; 

    std::vector<float> h_a(N, 1.0f); 
    std::vector<float> h_b(N, 2.0f);
    std::vector<float> h_c(N);      

    gpu_unique_ptr<float> d_a(gpu_allocator::allocate<float>(N));
    gpu_unique_ptr<float> d_b(gpu_allocator::allocate<float>(N));
    gpu_unique_ptr<float> d_c(gpu_allocator::allocate<float>(N));

    gpu_check(hipMemcpy(d_a.get(), h_a.data(), N * sizeof(float), hipMemcpyHostToDevice));
    gpu_check(hipMemcpy(d_b.get(), h_b.data(), N * sizeof(float), hipMemcpyHostToDevice));


    size_t threads_per_block = 256;
    size_t blocks_per_grid = (N + threads_per_block - 1) / threads_per_block;
    blocks_per_grid = std::min((size_t)65535, blocks_per_grid); 
    vector_add<<<blocks_per_grid, threads_per_block>>>(d_a.get(), d_b.get(), d_c.get(), N);

    gpu_check(hipPeekAtLastError());

    gpu_check(hipDeviceSynchronize());

    gpu_check(hipMemcpy(h_c.data(), d_c.get(), N * sizeof(float), hipMemcpyDeviceToHost));

    for (size_t i = 0; i < N; ++i) {
        if (h_c[i] != 3.0f) {
            std::cerr << "Mismatch at index " << i << ": " << h_c[i] << std::endl;
            return -1;
        }
    }

    std::cout << "Vector addition successful!" << std::endl;

    return 0;
}
