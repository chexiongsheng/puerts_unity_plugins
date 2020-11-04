mkdir -p build && cd build
cmake ../ 
cd ..
cmake --build build --config Release
mkdir -p qjs/Lib/Win64/
cp build/libqjs.a qjs/Lib/Win64/ 
