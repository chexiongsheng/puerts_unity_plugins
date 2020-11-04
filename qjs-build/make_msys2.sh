mkdir -p build && cd build
cmake -G"CodeBlocks - Unix Makefiles" -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ ../ 
cd ..
cmake --build build --config Release
mkdir -p ../qjs/Lib/Win64/
cp build/libqjs.a ../qjs/Lib/Win64/ 
