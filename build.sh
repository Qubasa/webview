#!/usr/bin/env bash


mkdir -p build
cd build
cmake .. -DWEBVIEW_ENABLE_CLANG_FORMAT=False -DWEBVIEW_BUILD_AMALGAMATION=False
make
