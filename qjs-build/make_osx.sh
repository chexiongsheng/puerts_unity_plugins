mkdir -p build && cd build
cmake -GXcode ../
cd ..
cmake --build build --config Release
mkdir -p ~/qjs/Lib/OSX/
cp build/Release/libqjs.a ~/qjs/Lib/OSX/
