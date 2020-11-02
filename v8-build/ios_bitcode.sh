VERSION=$1

cd ~
echo "=====[ Getting Depot Tools ]====="	
git clone -q https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$(pwd)/depot_tools:$PATH
gclient


mkdir v8
cd v8

echo "=====[ Fetching V8 ]====="
fetch v8
echo "target_os = ['ios']" >> .gclient
cd ~/v8/v8
git checkout refs/tags/$VERSION
gclient sync


echo "=====[ Building V8 ]====="
python ./tools/dev/v8gen.py arm.release -vv -- '
v8_use_external_startup_data = false
v8_use_snapshot = false
v8_enable_i18n_support = false
is_debug = false
v8_static_library = true
ios_enable_code_signing = false
target_os = "ios"
use_xcode_clang = true
v8_enable_pointer_compression = false
enable_ios_bitcode = true
'
ninja -C out.gn/arm.release -t clean
ninja -C out.gn/arm.release wee8


mkdir -p output/v8/Lib/iOS/bitcode
cp out.gn/arm.release/obj/libwee8.a output/v8/Lib/iOS/bitcode/
