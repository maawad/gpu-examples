cmake_minimum_required(VERSION 3.10)

project(HIPExamples LANGUAGES CXX HIP)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_HIP_STANDARD 23)
set(CMAKE_HIP_STANDARD_REQUIRED ON)

set(EXAMPLES
    DeviceQuery
    VectorAddThrust
    VectorAdd
)

foreach(EXAMPLE ${EXAMPLES})
    add_executable(${EXAMPLE} ${EXAMPLE}/${EXAMPLE}.hip)
endforeach()