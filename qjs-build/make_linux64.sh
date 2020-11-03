mkdir -p build_linux64 && cd build_linux64
cmake ../
cd ..
cmake --build build_linux64 --config Release
mkdir -p ~/qjs/Lib/Linux64/
cp build_linux64/libqjs.a ~/qjs/Lib/Linux64/ 
