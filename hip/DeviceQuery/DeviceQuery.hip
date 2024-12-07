#include <hip/hip_runtime.h>
#include <iomanip>
#include <iostream>
#include <sstream>

// Utility function to format UUID
std::string formatUUID(const hipUUID_t& uuid) {
  std::ostringstream ss;
  for (int i = 0; i < 16; ++i) {
    ss << std::hex << std::setfill('0') << std::setw(2)
       << static_cast<int>(static_cast<unsigned char>(uuid.bytes[i]));
    if (i == 3 || i == 5 || i == 7 || i == 9) {
      ss << "-";
    }
  }
  return ss.str();
}

void printDeviceProperties(const hipDeviceProp_t& props, int deviceId) {
  std::cout << std::left;  // Align output to the left
  std::cout << "Device " << deviceId << ": " << props.name << "\n";
  std::cout << std::setw(50) << "  UUID:" << formatUUID(props.uuid) << "\n";
  std::cout << std::setw(50) << "  Total Global Memory:"
            << props.totalGlobalMem / (1024.0 * 1024.0) << " MB\n";
  std::cout << std::setw(50)
            << "  Shared Memory Per Block:" << props.sharedMemPerBlock / 1024.0
            << " KB\n";
  std::cout << std::setw(50) << "  Registers Per Block:" << props.regsPerBlock
            << "\n";
  std::cout << std::setw(50) << "  Warp Size:" << props.warpSize << "\n";
  std::cout << std::setw(50) << "  Memory Pitch:" << props.memPitch / 1024.0
            << " KB\n";
  std::cout << std::setw(50)
            << "  Max Threads Per Block:" << props.maxThreadsPerBlock << "\n";
  std::cout << std::setw(50) << "  Max Threads Dimensions:"
            << "(" << props.maxThreadsDim[0] << ", " << props.maxThreadsDim[1]
            << ", " << props.maxThreadsDim[2] << ")\n";
  std::cout << std::setw(50) << "  Max Grid Dimensions:"
            << "(" << props.maxGridSize[0] << ", " << props.maxGridSize[1]
            << ", " << props.maxGridSize[2] << ")\n";
  std::cout << std::setw(50) << "  Clock Rate:" << props.clockRate / 1000.0
            << " MHz\n";
  std::cout << std::setw(50)
            << "  Total Constant Memory:" << props.totalConstMem / 1024.0
            << " KB\n";
  std::cout << std::setw(50) << "  Compute Capability:" << props.major << "."
            << props.minor << "\n";
  std::cout << std::setw(50)
            << "  Multi-Processor Count:" << props.multiProcessorCount << "\n";
  std::cout << std::setw(50)
            << "  Memory Clock Rate:" << props.memoryClockRate / 1000.0
            << " MHz\n";
  std::cout << std::setw(50) << "  Memory Bus Width:" << props.memoryBusWidth
            << " bits\n";
  std::cout << std::setw(50) << "  L2 Cache Size:" << props.l2CacheSize / 1024.0
            << " KB\n";
  std::cout << std::setw(50) << "  Max Threads Per MultiProcessor:"
            << props.maxThreadsPerMultiProcessor << "\n";
  std::cout << std::setw(50)
            << "  Registers Per MultiProcessor:" << props.regsPerMultiprocessor
            << "\n";
  std::cout << std::setw(50) << "  Shared Memory Per MultiProcessor:"
            << props.sharedMemPerMultiprocessor / 1024.0 << " KB\n";
  std::cout << std::setw(50) << "  PCI Bus ID:" << props.pciBusID << "\n";
  std::cout << std::setw(50) << "  PCI Device ID:" << props.pciDeviceID << "\n";
  std::cout << std::setw(50) << "  PCI Domain ID:" << props.pciDomainID << "\n";
  std::cout << std::setw(50)
            << "  Cooperative Launch Supported:" << props.cooperativeLaunch
            << "\n";
  std::cout << std::setw(50) << "  Cooperative Multi-Device Launch Supported:"
            << props.cooperativeMultiDeviceLaunch << "\n";
  std::cout << std::setw(50)
            << "  Memory Pools Supported:" << props.memoryPoolsSupported
            << "\n";
  std::cout << std::setw(50) << "  Is Large Bar:" << props.isLargeBar << "\n";
  std::cout << std::setw(50) << "  ASIC Revision:" << props.asicRevision
            << "\n";
  std::cout << std::left;
  std::cout << std::setw(40)
            << "  Texture Alignment (Bytes):" << props.textureAlignment << "\n";
  std::cout << std::setw(40) << "  Texture Pitch Alignment (Bytes):"
            << props.texturePitchAlignment << "\n";
  std::cout << std::setw(40)
            << "  Device Overlap (Deprecated):" << props.deviceOverlap << "\n";
  std::cout << std::setw(40)
            << "  Multi-Processor Count:" << props.multiProcessorCount << "\n";
  std::cout << std::setw(40) << "  Kernel Exec Timeout Enabled:"
            << props.kernelExecTimeoutEnabled << "\n";
  std::cout << std::setw(40) << "  Integrated Device:" << props.integrated
            << "\n";
  std::cout << std::setw(40)
            << "  Can Map Host Memory:" << props.canMapHostMemory << "\n";
  std::cout << std::setw(40) << "  Compute Mode:" << props.computeMode << "\n";
  std::cout << std::setw(40) << "  Max Texture 1D:" << props.maxTexture1D
            << "\n";
  std::cout << std::setw(40)
            << "  Max Texture 1D Mipmap:" << props.maxTexture1DMipmap << "\n";
  std::cout << std::setw(40)
            << "  Max Texture 1D Linear:" << props.maxTexture1DLinear << "\n";
  std::cout << std::setw(40) << "  Max Texture 2D (Width, Height):"
            << "[" << props.maxTexture2D[0] << ", " << props.maxTexture2D[1]
            << "]\n";
  std::cout << std::setw(40) << "  Max Texture 2D Mipmap (Width, Height):"
            << "[" << props.maxTexture2DMipmap[0] << ", "
            << props.maxTexture2DMipmap[1] << "]\n";
  std::cout << std::setw(40)
            << "  Max Texture 2D Linear (Width, Height, Depth):"
            << "[" << props.maxTexture2DLinear[0] << ", "
            << props.maxTexture2DLinear[1] << ", "
            << props.maxTexture2DLinear[2] << "]\n";
  std::cout << std::setw(40) << "  Max Texture 2D Gather (Width, Height):"
            << "[" << props.maxTexture2DGather[0] << ", "
            << props.maxTexture2DGather[1] << "]\n";
  std::cout << std::setw(40) << "  Max Texture 3D (Width, Height, Depth):"
            << "[" << props.maxTexture3D[0] << ", " << props.maxTexture3D[1]
            << ", " << props.maxTexture3D[2] << "]\n";
  std::cout << std::setw(50) << "  Max Texture 3D Alt (Width, Height, Depth):"
            << "[" << props.maxTexture3DAlt[0] << ", "
            << props.maxTexture3DAlt[1] << ", " << props.maxTexture3DAlt[2]
            << "]\n";
  std::cout << std::setw(50)
            << "  Max Texture Cubemap:" << props.maxTextureCubemap << "\n";
  std::cout << std::setw(50) << "  Max Texture 1D Layered (Width, Layers):"
            << "[" << props.maxTexture1DLayered[0] << ", "
            << props.maxTexture1DLayered[1] << "]\n";
  std::cout << std::setw(50)
            << "  Max Texture 2D Layered (Width, Height, Layers):"
            << "[" << props.maxTexture2DLayered[0] << ", "
            << props.maxTexture2DLayered[1] << ", "
            << props.maxTexture2DLayered[2] << "]\n";
  std::cout << std::setw(50) << "  Max Texture Cubemap Layered (Width, Layers):"
            << "[" << props.maxTextureCubemapLayered[0] << ", "
            << props.maxTextureCubemapLayered[1] << "]\n";
  std::cout << std::setw(50) << "  Max Surface 1D:" << props.maxSurface1D
            << "\n";
  std::cout << std::setw(50) << "  Max Surface 2D (Width, Height):"
            << "[" << props.maxSurface2D[0] << ", " << props.maxSurface2D[1]
            << "]\n";
  std::cout << std::setw(50) << "  Max Surface 3D (Width, Height, Depth):"
            << "[" << props.maxSurface3D[0] << ", " << props.maxSurface3D[1]
            << ", " << props.maxSurface3D[2] << "]\n";
  std::cout << std::setw(50) << "  Max Surface 1D Layered (Width, Layers):"
            << "[" << props.maxSurface1DLayered[0] << ", "
            << props.maxSurface1DLayered[1] << "]\n";
  std::cout << std::setw(50)
            << "  Max Surface 2D Layered (Width, Height, Layers):"
            << "[" << props.maxSurface2DLayered[0] << ", "
            << props.maxSurface2DLayered[1] << ", "
            << props.maxSurface2DLayered[2] << "]\n";
  std::cout << std::setw(50)
            << "  Max Surface Cubemap:" << props.maxSurfaceCubemap << "\n";
  std::cout << std::setw(50) << "  Max Surface Cubemap Layered (Width, Layers):"
            << "[" << props.maxSurfaceCubemapLayered[0] << ", "
            << props.maxSurfaceCubemapLayered[1] << "]\n";
  std::cout << std::setw(50)
            << "  Surface Alignment (Bytes):" << props.surfaceAlignment << "\n";
  std::cout << std::setw(50)
            << "  Concurrent Kernels Supported:" << props.concurrentKernels
            << "\n";
  std::cout << std::setw(50) << "  ECC Enabled:" << props.ECCEnabled << "\n";
  std::cout << std::setw(50) << "  PCI Bus ID:" << props.pciBusID << "\n";
  std::cout << std::setw(50) << "  PCI Device ID:" << props.pciDeviceID << "\n";
  std::cout << std::setw(50) << "  PCI Domain ID:" << props.pciDomainID << "\n";
  std::cout << std::setw(50) << "  TCC Driver:" << props.tccDriver << "\n";
  std::cout << std::setw(50)
            << "  Async Engine Count:" << props.asyncEngineCount << "\n";
  std::cout << std::setw(50)
            << "  Unified Addressing Supported:" << props.unifiedAddressing
            << "\n";
  std::cout << std::setw(50)
            << "  Memory Clock Rate (MHz):" << props.memoryClockRate / 1000.0
            << "\n";
  std::cout << std::setw(50)
            << "  Memory Bus Width (bits):" << props.memoryBusWidth << "\n";
  std::cout << std::setw(50)
            << "  L2 Cache Size (KB):" << props.l2CacheSize / 1024.0 << "\n";
  std::cout << std::setw(50) << "  Persisting L2 Cache Max Size (Bytes):"
            << props.persistingL2CacheMaxSize << "\n";
  std::cout << std::setw(50) << "  Max Threads Per Multi-Processor:"
            << props.maxThreadsPerMultiProcessor << "\n";
  std::cout << std::setw(50) << "  Stream Priorities Supported:"
            << props.streamPrioritiesSupported << "\n";
  std::cout << std::setw(50)
            << "  Global L1 Cache Supported:" << props.globalL1CacheSupported
            << "\n";
  std::cout << std::setw(50)
            << "  Local L1 Cache Supported:" << props.localL1CacheSupported
            << "\n";
  std::cout << std::setw(50) << "  Shared Memory Per Multi-Processor (KB):"
            << props.sharedMemPerMultiprocessor / 1024.0 << "\n";
  std::cout << std::setw(50)
            << "  Registers Per Multi-Processor:" << props.regsPerMultiprocessor
            << "\n";
  std::cout << std::setw(50)
            << "  Managed Memory Supported:" << props.managedMemory << "\n";
  std::cout << std::setw(50) << "  Is Multi-GPU Board:" << props.isMultiGpuBoard
            << "\n";
  std::cout << std::setw(50)
            << "  Multi-GPU Board Group ID:" << props.multiGpuBoardGroupID
            << "\n";
  std::cout << std::setw(50) << "  Host Native Atomic Supported:"
            << props.hostNativeAtomicSupported << "\n";
  std::cout << std::setw(50) << "  Single-to-Double Precision Perf Ratio:"
            << props.singleToDoublePrecisionPerfRatio << "\n";
  std::cout << std::setw(50) << "  Pageable Memory Access Supported:"
            << props.pageableMemoryAccess << "\n";
  std::cout << std::setw(50) << "  Concurrent Managed Access Supported:"
            << props.concurrentManagedAccess << "\n";
  std::cout << std::setw(50) << "  Compute Preemption Supported:"
            << props.computePreemptionSupported << "\n";
  std::cout << std::setw(50) << "  Can Use Host Pointer For Registered Mem:"
            << props.canUseHostPointerForRegisteredMem << "\n";
  std::cout << std::setw(50)
            << "  Cooperative Launch Supported:" << props.cooperativeLaunch
            << "\n";
  std::cout << std::setw(50) << "  Cooperative Multi-Device Launch Supported:"
            << props.cooperativeMultiDeviceLaunch << "\n";
  std::cout << std::setw(50) << "  Shared Memory Per Block (Opt-In) (KB):"
            << props.sharedMemPerBlockOptin / 1024.0 << "\n";
  std::cout << std::setw(50)
            << "  Pageable Memory Access Uses Host Page Tables:"
            << props.pageableMemoryAccessUsesHostPageTables << "\n";
  std::cout << std::setw(50) << "  Direct Managed Mem Access From Host:"
            << props.directManagedMemAccessFromHost << "\n";
  std::cout << std::setw(50) << "  Max Blocks Per Multi-Processor:"
            << props.maxBlocksPerMultiProcessor << "\n";
  std::cout << std::setw(50) << "  Access Policy Max Window Size:"
            << props.accessPolicyMaxWindowSize << "\n";
  std::cout << std::setw(50) << "  Reserved Shared Mem Per Block (Bytes):"
            << props.reservedSharedMemPerBlock << "\n";
  std::cout << std::setw(50)
            << "  Host Register Supported:" << props.hostRegisterSupported
            << "\n";
  std::cout << std::setw(50)
            << "  Sparse HIP Array Supported:" << props.sparseHipArraySupported
            << "\n";
  std::cout << std::setw(50) << "  Host Register Read-Only Supported:"
            << props.hostRegisterReadOnlySupported << "\n";
  std::cout << std::setw(50) << "  Timeline Semaphore Interop Supported:"
            << props.timelineSemaphoreInteropSupported << "\n";
  std::cout << std::setw(50)
            << "  Memory Pools Supported:" << props.memoryPoolsSupported
            << "\n";
  std::cout << std::setw(50)
            << "  GPU Direct RDMA Supported:" << props.gpuDirectRDMASupported
            << "\n";
  std::cout << std::setw(50) << "  GPU Direct RDMA Flush Writes Options:"
            << props.gpuDirectRDMAFlushWritesOptions << "\n";
  std::cout << std::setw(50) << "  GPU Direct RDMA Writes Ordering:"
            << props.gpuDirectRDMAWritesOrdering << "\n";
  std::cout << std::setw(50) << "  Memory Pool Supported Handle Types:"
            << props.memoryPoolSupportedHandleTypes << "\n";
  std::cout << std::setw(50) << "  Deferred Mapping HIP Array Supported:"
            << props.deferredMappingHipArraySupported << "\n";
  std::cout << std::setw(50)
            << "  IPC Event Supported:" << props.ipcEventSupported << "\n";
  std::cout << std::setw(50)
            << "  Cluster Launch Supported:" << props.clusterLaunch << "\n";
  std::cout << std::setw(50) << "  Unified Function Pointers Supported:"
            << props.unifiedFunctionPointers << "\n";
  std::cout << std::setw(50) << "  GCN Arch Name:" << props.gcnArchName << "\n";
  std::cout << std::setw(50) << "  Max Shared Memory Per MultiProcessor (KB):"
            << props.maxSharedMemoryPerMultiProcessor / 1024.0 << "\n";
  std::cout << std::setw(50) << "  Clock Instruction Rate (MHz):"
            << props.clockInstructionRate / 1000.0 << "\n";
  std::cout << std::setw(50)
            << "  Cooperative Multi-Device Unmatched Functions:"
            << props.cooperativeMultiDeviceUnmatchedFunc << "\n";
  std::cout << std::setw(50)
            << "  Cooperative Multi-Device Unmatched Grid Dimensions:"
            << props.cooperativeMultiDeviceUnmatchedGridDim << "\n";
  std::cout << std::setw(50)
            << "  Cooperative Multi-Device Unmatched Block Dimensions:"
            << props.cooperativeMultiDeviceUnmatchedBlockDim << "\n";
  std::cout << std::setw(50)
            << "  Cooperative Multi-Device Unmatched Shared Memory:"
            << props.cooperativeMultiDeviceUnmatchedSharedMem << "\n";
  std::cout << std::setw(50) << "  Is Large PCI Bar Device:" << props.isLargeBar
            << "\n";
  std::cout << std::setw(50) << "  ASIC Revision:" << props.asicRevision
            << "\n";
  std::cout << "\n";
}
int main(int argc, char* argv[]) {
  int deviceId = -1;

  // Parse command-line arguments
  for (int i = 1; i < argc; ++i) {
    std::string arg = argv[i];
    if ((arg == "--device" || arg == "-d") && i + 1 < argc) {
      deviceId = std::stoi(argv[++i]);
    }
  }

  int deviceCount = 0;
  hipError_t err = hipGetDeviceCount(&deviceCount);

  if (err != hipSuccess) {
    std::cerr << "Error querying device count: " << hipGetErrorString(err)
              << "\n";
    return 1;
  }

  if (deviceCount == 0) {
    std::cout << "No HIP-compatible devices found.\n";
    return 0;
  }

  if (deviceId >= deviceCount || deviceId < -1) {
    std::cerr << "Invalid device ID specified. Valid range: 0 to "
              << deviceCount - 1 << ".\n";
    return 1;
  }

  if (deviceId == -1) {
    std::cout << "Number of HIP-compatible devices: " << deviceCount << "\n\n";
    for (int i = 0; i < deviceCount; ++i) {
      hipDeviceProp_t props;
      err = hipGetDeviceProperties(&props, i);
      if (err != hipSuccess) {
        std::cerr << "Error querying properties for device " << i << ": "
                  << hipGetErrorString(err) << "\n";
        continue;
      }
      printDeviceProperties(props, i);
    }
  } else {
    hipDeviceProp_t props;
    err = hipGetDeviceProperties(&props, deviceId);
    if (err != hipSuccess) {
      std::cerr << "Error querying properties for device " << deviceId << ": "
                << hipGetErrorString(err) << "\n";
      return 1;
    }
    printDeviceProperties(props, deviceId);
  }

  return 0;
}