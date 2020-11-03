mkdir -p build && cd build
cmake cmake -G"Unix Makefiles" ../ -DCMAKE_TOOLCHAIN_FILE=toolchain-mingw64.cmake
cd ..
cmake --build build --config Release
mkdir -p qjs/Lib/Win64/
cp build/libqjs.a qjs/Lib/Win64/ 
