mkdir -p build_ios && cd build_ios
cmake -DLUA_VERSION=5.4.1 -DCMAKE_TOOLCHAIN_FILE=../cmake/ios.toolchain.cmake -DPLATFORM=OS64 -GXcode ../
cd ..
cmake --build build_ios --config Release
mkdir -p ~/qjs/Lib/iOS/
cp build_ios/Release-iphoneos/libqjs.a ~/qjs/Lib/iOS/

