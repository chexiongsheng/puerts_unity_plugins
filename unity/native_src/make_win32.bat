mkdir build32 & pushd build32
cmake -G "Visual Studio 16 2019" -A Win32 ..
popd
cmake --build build32 --config Release
copy build32\Release\puerts.dll ..\Assets\Plugins\x86
pause