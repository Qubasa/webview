#!/usr/bin/env bash


rm -rf build
mkdir -p build
cd build
cmake .. -DWEBVIEW_ENABLE_CLANG_FORMAT=False -DWEBVIEW_BUILD_AMALGAMATION=False -DCMAKE_CXX_FLAGS="-g -O1"
make
