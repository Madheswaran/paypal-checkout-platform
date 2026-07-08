cmake_minimum_required(VERSION 3.10)

project(token-service)

set(CMAKE_CXX_STANDARD 17)

include_directories(include)

add_executable(token-service
    src/main.cpp
)
